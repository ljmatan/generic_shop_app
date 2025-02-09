library api;

import 'dart:async' as dart_async;
import 'dart:convert' as dart_convert;
import 'dart:io' as dart_io;

import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

import '../db/database.dart';
import '../router/router.dart';
import '../server.dart';

part 'src/aggregated/v0/api_aggregated.dart';
part 'src/aggregated/v0/api_aggregated_endpoints.dart';
part 'src/merchants/v0/api_merchants.dart';
part 'src/merchants/v0/api_merchants_endpoints.dart';
part 'src/orders/v0/api_orders.dart';
part 'src/orders/v0/api_orders_endpoints.dart';
part 'src/sale_items/v0/api_sale_items.dart';
part 'src/sale_items/v0/api_sale_items_endpoints.dart';
part 'src/users/v0/api_users.dart';
part 'src/users/v0/api_users_endpoints.dart';

abstract class GsamApi {
  GsamApi._() {
    _observables.add(this);
  }

  /// Collection of active subclass instances.
  ///
  static final _observables = <GsamApi>[];

  /// Global public API identifier.
  ///
  final majorVersion = 0;

  /// Identifier for the specific version of the sublcassed API services.
  ///
  int get version;

  /// URL path identifier designed to be implemented the subclass instances.
  ///
  String get identifier;

  /// Collection of public API endpoints and their respective methods.
  ///
  List<
      ({
        String path,
        GsaApiEndpointMethodType method,
        Future<shelf.Response> Function(shelf.Request) handler,
      })> get endpoints;

  /// Sets up the router endpoints and binds them to the appropriate handler methods.
  ///
  void _init() {
    final router = shelf_router.Router();
    GsamRouterType.api.router.mount('/api/v$majorVersion/$identifier/v$version', router.call);
    for (final endpoint in endpoints) {
      switch (endpoint.method) {
        case GsaApiEndpointMethodType.httpGet:
          router.get('/${endpoint.path}', endpoint.handler);
          break;
        case GsaApiEndpointMethodType.httpPost:
          router.post('/${endpoint.path}', endpoint.handler);
          break;
        case GsaApiEndpointMethodType.httpPut:
          router.put('/${endpoint.path}', endpoint.handler);
          break;
        case GsaApiEndpointMethodType.httpPatch:
          router.patch('/${endpoint.path}', endpoint.handler);
          break;
        case GsaApiEndpointMethodType.httpDelete:
          router.delete('/${endpoint.path}', endpoint.handler);
          break;
      }
    }
  }

  /// Invokes the [_init] method on all of the sublcass instances.
  ///
  static void initAll() {
    for (final observable in _observables) {
      observable._init();
    }
  }

  /// Currently-active authenticated user sessions.
  ///
  static final _sessions = <({String key, String userId})>{
    (
      key: GsamConfig.adminKey,
      userId: 'admin',
    ),
  };

  /// The amount of time the user is authenticated with a single session key.
  ///
  /// After this time has passed, the given token should be considered as invalid.
  ///
  static const _sessionDuration = Duration(days: 7);

  /// Creates an authenticated user session with the provided [userId] and [token].
  ///
  void _createSession({
    required String token,
    required String userId,
  }) {
    final session = (key: token, userId: userId);
    _sessions.add(session);
    Future.delayed(_sessionDuration, () {
      _sessions.remove(session);
    });
  }

  /// Removes any data not meant for end-user from a database record data instance.
  ///
  void _removeInternalJsonData(Map<String, dynamic> data) {
    for (final key in <String>{
      '_id',
      'originId',
      'logs',
    }) {
      data.remove(key);
    }
  }

  /// Constructs a HTTP response with status code 200,
  /// which indicates that the request has succeeded.
  ///
  shelf.Response _responseOk({
    String? message,
    Map<String, dynamic>? body,
  }) {
    if (body != null) _removeInternalJsonData(body);
    return shelf.Response(
      200,
      body: dart_convert.jsonEncode(
        body ??
            {
              'message': message ?? 'OK',
            },
      ),
    );
  }

  /// Constructs a HTTP response with status code 500,
  /// which indicates that an internal server error has occurred.
  ///
  shelf.Response _responseError({
    String? message,
    Map<String, dynamic>? body,
  }) {
    if (body != null) _removeInternalJsonData(body);
    return shelf.Response(
      500,
      body: dart_convert.jsonEncode(
        body ??
            {
              'message': message ?? 'OK',
            },
      ),
    );
  }

  /// Constructs a HTTP response with status code 401,
  /// which indicates that the caller does not have the required permissions to access the source content.
  ///
  shelf.Response _responseUnauthorized({
    String? message,
    Map<String, dynamic>? body,
  }) {
    if (body != null) _removeInternalJsonData(body);
    return shelf.Response(
      401,
      body: dart_convert.jsonEncode(
        body ??
            {
              'message': message ?? 'OK',
            },
      ),
    );
  }

  /// Constructs a HTTP response with status code 301,
  /// which indicates that the caller client should be forwarded to the [targetUrl].
  ///
  shelf.Response _responseRedirect(String targetUrl) {
    return shelf.Response(
      301,
      headers: {
        'Location': targetUrl,
      },
    );
  }

  Future<shelf.Response> _parseRequest(
    shelf.Request request,
    dart_async.FutureOr<shelf.Response> Function(
      Map<String, String> requestHeaders,
      Map<String, dynamic>? requestBody,
      String? userId,
    ) handler, {
    bool requiresSpecialAuthentication = false,
    bool requiresAuthentication = false,
    bool requiresUserId = false,
    List<String>? accessTags,
    List<(String, Type)>? requestBodyTypeChecks,
  }) async {
    String? userId;
    if (requiresSpecialAuthentication || requiresAuthentication || requiresUserId) {
      final authKey = request.headers['Gsa-Auth-Key'];
      if (authKey?.isNotEmpty != true) {
        return _responseUnauthorized(
          message: 'Authentication key missing.',
        );
      }
      final specialCheckFail = requiresSpecialAuthentication && _sessions.elementAt(0).key != authKey;
      if (specialCheckFail) {
        return _responseUnauthorized(
          message: 'Special authorization check fail.',
        );
      }
      final matchingSessions = _sessions.where((session) => session.key == authKey);
      if (requiresAuthentication && matchingSessions.isEmpty) {
        return _responseUnauthorized(
          message: 'No matching sessions.',
        );
      }
      userId = matchingSessions.elementAt(0).userId;
      if (requiresAuthentication && accessTags?.isNotEmpty == true) {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId);
        if (user?.tags?.any((tag) => accessTags?.contains(tag) == true) != true) {
          return _responseUnauthorized();
        }
      }
    }
    if (requiresUserId && userId == null) {
      return _responseUnauthorized(
        message: 'No user ID found.',
      );
    }
    Map<String, dynamic>? requestBody;
    try {
      final requestBodyString = await request.readAsString();
      requestBody = Map<String, dynamic>.from(dart_convert.jsonDecode(requestBodyString));
      if (requestBodyTypeChecks?.isNotEmpty == true) {
        for (final typeCheck in requestBodyTypeChecks!) {
          final referenceValue = requestBody[typeCheck.$1];
          if (referenceValue.runtimeType != typeCheck.$2) {
            // TODO: Log type check error
            return _responseError(
              message: '${referenceValue.runtimeType} is not of type ${typeCheck.$2}.',
            );
          }
        }
      }
    } catch (e) {
      // TODO: Log for potential type errors.
      if (requestBodyTypeChecks?.isNotEmpty == true) {
        return _responseError(
          message: '$e and requestBodyExpected.',
        );
      }
    }
    return await handler(request.headers, requestBody, userId);
  }
}
