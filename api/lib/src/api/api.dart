/// Library aimed at providing access features for REST API and GraphQL API backend services.

// ignore_for_file: unused_element

library api;

import 'dart:convert' as dart_convert;

import 'package:http/http.dart' as http;

/// A base class for the HTTP client services.
///
abstract class GsaaApi {
  /// Constant constructor definition implementation for the subclasses.
  ///
  const GsaaApi();

  /// Network request protocol.
  ///
  String get protocol => 'https';

  /// Network request server host address.
  ///
  String get host => 'localhost';

  /// The major public API version defined with the server.
  ///
  int? get majorVersion => 0;

  /// API identifier with the backend services.
  ///
  String? get identifier => null;

  /// The version specific to this API.
  ///
  int? get version => null;

  /// Address in URL format.
  ///
  String get url {
    return '$protocol://$host/api/v$majorVersion/$identifier/v$version/';
  }

  /// Headers appended to the default request [headers].
  ///
  /// Overriding this property is used to provide additional headers,
  /// while the headers can be entirely replaced by overriding the [headers] property.
  ///
  Map<String, String> get additionalHeaders {
    return {};
  }

  /// Default HTTP request headers.
  ///
  /// Additional headers can be appended to these by overriding the [additionalHeaders] property,
  /// while the entire header content can be replaced by overriding this property.
  ///
  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json; charset=utf-8',
    }..addAll(additionalHeaders);
  }

  /// Maximum time allowed before a response is received from a request.
  ///
  Duration get _timeoutDuration => const Duration(seconds: 10);

  /// Default HTTP request and response handler.
  ///
  Future<dynamic> _httpRequest(
    Future<http.Response> Function() request, {
    required bool decodedResponse,
  }) async {
    final requestTime = DateTime.now();
    try {
      final response = await request();
      final uri = Uri.parse('${response.request?.url}');
      dynamic decodedRequestBody, decodedResponseBody;
      try {
        decodedRequestBody = dart_convert.jsonDecode(
          dart_convert.utf8.decode((response.request as http.Request?)!.bodyBytes),
        );
      } catch (e) {
        // Do nothing.
      }
      try {
        decodedResponseBody = dart_convert.jsonDecode(response.body);
      } catch (e) {
        // Do nothing.
      }
      try {
        // TODO: Fix logging.
        // GsaServiceLogging.logNetworkRequest(
        //   statusCode: response.statusCode,
        //   requestTime: requestTime,
        //   uri: uri,
        //   method: '${response.request?.method}',
        //   requestBody: (decodedRequestBody ?? <String, dynamic>{}),
        //   responseBody: decodedResponseBody ?? <String, dynamic>{},
        //   requestHeaders: response.request?.headers ?? <String, String>{},
        //   responseHeaders: response.headers,
        // );
      } catch (e) {
        // Do nothing.
      }
      return decodedResponse ? dart_convert.jsonDecode(response.body) : response;
    } catch (e) {
      rethrow;
    }
  }

  /// Sends an HTTP GET request with the given headers to the given URL.
  ///
  Future<dynamic> get(
    String endpoint, {
    bool decodedResponse = true,
  }) async {
    return await _httpRequest(
      () async => http.get(
        Uri.parse('$url$endpoint'),
        headers: _headers,
      ),
      decodedResponse: decodedResponse,
    );
  }

  /// Sends an HTTP POST request with the given headers and body to the given URL.
  ///
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool decodedResponse = true,
  }) async {
    return await _httpRequest(
      () async => http.post(
        Uri.parse('$url$endpoint'),
        headers: _headers,
        body: dart_convert.jsonEncode(body),
      ),
      decodedResponse: decodedResponse,
    );
  }

  /// Sends an HTTP PUT request with the given headers and body to the given URL.
  ///
  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool decodedResponse = true,
  }) async {
    return await _httpRequest(
      () async => http.put(
        Uri.parse('$url$endpoint'),
        headers: _headers,
        body: dart_convert.jsonEncode(body),
      ),
      decodedResponse: decodedResponse,
    );
  }

  /// Sends an HTTP PATCH request with the given headers and body to the given URL.
  ///
  Future<dynamic> patch(
    String endpoint,
    Map<String, dynamic> body, {
    bool decodedResponse = true,
  }) async {
    return await _httpRequest(
      () async => http.patch(
        Uri.parse('$url$endpoint'),
        headers: _headers,
        body: dart_convert.jsonEncode(body),
      ),
      decodedResponse: decodedResponse,
    );
  }

  /// Sends an HTTP DELETE request with the given headers to the given URL.
  ///
  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? body,
    bool decodedResponse = true,
  }) async {
    return await _httpRequest(
      () async => http.delete(
        Uri.parse('$url$endpoint'),
        headers: _headers,
        body: body,
      ),
      decodedResponse: decodedResponse,
    );
  }
}
