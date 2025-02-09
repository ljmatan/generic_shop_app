part of '../../../api.dart';

class GsamApiOrders0 extends GsamApi {
  GsamApiOrders0._() : super._();

  static final instance = GsamApiOrders0._();

  @override
  int get version => 0;

  @override
  String get identifier => 'orders';

  @override
  List<
      ({
        String path,
        GsaApiEndpointMethodType method,
        Future<shelf.Response> Function(shelf.Request) handler,
      })> get endpoints {
    return [
      for (final endpoint in GsaEndpointsOrders.values)
        (
          path: endpoint.path,
          method: endpoint.method,
          handler: endpoint.handler,
        ),
    ];
  }

  Future<shelf.Response> register(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = GsaModelUser.fromJson(requestBody!);
        final existingUser = await GsamDatabaseUsers.instance(request).findByUsername(
          username: user.username!,
        );
        if (existingUser != null) {
          return _responseError(message: 'Username already registered.');
        }
        final password = requestBody['password'] as String;
        await GsamDatabaseUsers.instance(request).register(
          user: user,
          password: password,
        );
        return _responseOk();
      },
      requestBodyTypeChecks: [
        ('username', String),
        ('password', String),
      ],
    );
  }

  Future<shelf.Response> getItemDetails(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          return _responseOk(
            body: user.toJson(),
          );
        }
      },
    );
  }

  Future<shelf.Response> editItemDetails(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          await GsamDatabaseUsers.instance(request).updateUserDetails(
            userId: user.id!,
            body: requestBody!,
          );
          return _responseOk();
        }
      },
      requestBodyTypeChecks: [
        ('token', String),
      ],
    );
  }

  Future<shelf.Response> delete(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          await GsamDatabaseUsers.instance(request).delete(userId: user.id!);
          return _responseOk();
        }
      },
      requestBodyTypeChecks: [
        ('token', String),
      ],
    );
  }

  Future<shelf.Response> softDelete(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          await GsamDatabaseUsers.instance(request).softDelete(userId: user.id!);
          return _responseOk();
        }
      },
      requestBodyTypeChecks: [
        ('token', String),
      ],
    );
  }

  Future<shelf.Response> createOrUpdateDraft(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          await GsamDatabaseUsers.instance(request).softDelete(userId: user.id!);
          return _responseOk();
        }
      },
      requestBodyTypeChecks: [
        ('token', String),
      ],
    );
  }

  Future<shelf.Response> confirmDraft(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          await GsamDatabaseUsers.instance(request).softDelete(userId: user.id!);
          return _responseOk();
        }
      },
      requestBodyTypeChecks: [
        ('token', String),
      ],
    );
  }
}
