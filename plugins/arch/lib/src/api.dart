import 'dart:convert' as dart_convert;

import 'package:http/http.dart' as http;

/// A base class for the HTTP client services.
///
abstract class GsarApi {
  /// Constant constructor definition implementation for the subclasses.
  ///
  const GsarApi();

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
    return '$protocol://$host/';
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
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json; charset=utf-8',
    }..addAll(additionalHeaders);
  }

  /// Maximum time allowed before a response is received from a request.
  ///
  Duration get _timeoutDuration => const Duration(seconds: 10);

  /// Logs recorded during the application runtime.
  ///
  static final logs = <GsarApiModelLog>[];

  /// Whether the logging functionality is enabled for an API subclass instance.
  ///
  bool get loggingEnabled => true;

  /// Creates a new log entry from the provided data.
  ///
  Future<void> _log(GsarApiModelLog log) async {
    if (!loggingEnabled) return;
    logs.add(log);
  }

  /// Default HTTP request and response handler.
  ///
  Future<dynamic> _httpRequest(
    Future<http.Response> Function() request, {
    required bool decodedResponse,
  }) async {
    final requestTime = DateTime.now();
    try {
      final response = await request().timeout(_timeoutDuration);
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
        _log(
          GsarApiModelLog(
            statusCode: response.statusCode,
            requestTime: requestTime,
            responseTime: DateTime.now(),
            url: uri.toString(),
            method: '${response.request?.method}',
            requestBody: (decodedRequestBody ?? <String, dynamic>{}),
            responseBody: decodedResponseBody ?? <String, dynamic>{},
            requestHeaders: response.request?.headers ?? <String, String>{},
            responseHeaders: response.headers,
          ),
        );
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
        headers: headers,
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
        headers: headers,
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
        headers: headers,
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
        headers: headers,
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
        headers: headers,
        body: body,
      ),
      decodedResponse: decodedResponse,
    );
  }
}

/// Model class defining the network log data structure.
///
class GsarApiModelLog {
  const GsarApiModelLog({
    required this.statusCode,
    required this.requestTime,
    required this.responseTime,
    required this.url,
    required this.requestBody,
    required this.responseBody,
    required this.requestHeaders,
    required this.responseHeaders,
    required this.method,
  });

  /// HTTP response status codes indicating whether the HTTP request has been successfully completed.
  ///
  final int statusCode;

  /// Logged request time.
  ///
  final DateTime requestTime, responseTime;

  /// Server endpoint information.
  ///
  final String url;

  /// Server endpoint information.
  ///
  Uri get uri => Uri.parse(url);

  /// HTTP request transactional data.
  ///
  final dynamic requestBody, responseBody;

  /// HTTP request transactional data.
  ///
  final Map<String, String> requestHeaders, responseHeaders;

  /// String representation of the given HTTP method.
  ///
  final String method;

  // ignore: public_member_api_docs
  factory GsarApiModelLog.fromJson(Map<String, dynamic> json) {
    return GsarApiModelLog(
      statusCode: json['statusCode'] ?? -1,
      requestTime: DateTime.tryParse(json['requestTime']) ?? DateTime.now(),
      responseTime: DateTime.tryParse(json['responseTime']) ?? DateTime.now(),
      url: json['url'] ?? 'N/A',
      requestBody: json['requestBody'] ?? {},
      responseBody: json['responseBody'] ?? {},
      requestHeaders: Map<String, String>.from(json['requestHeaders'] ?? {}),
      responseHeaders: Map<String, String>.from(json['responseHeaders'] ?? {}),
      method: json['method'] ?? 'N/A',
    );
  }

  // ignore: public_member_api_docs
  factory GsarApiModelLog.fromEncodedJson(String encodedJson) {
    final Map<String, dynamic> json = dart_convert.jsonDecode(encodedJson);
    return GsarApiModelLog(
      statusCode: json['statusCode'] ?? -1,
      requestTime: DateTime.tryParse(json['requestTime']) ?? DateTime.now(),
      responseTime: DateTime.tryParse(json['responseTime']) ?? DateTime.now(),
      url: json['url'] ?? 'N/A',
      requestBody: json['requestBody'] ?? {},
      responseBody: json['responseBody'] ?? {},
      requestHeaders: Map<String, String>.from(json['requestHeaders'] ?? {}),
      responseHeaders: Map<String, String>.from(json['responseHeaders'] ?? {}),
      method: json['method'] ?? 'N/A',
    );
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'requestTime': requestTime.toIso8601String(),
      'responseTime': responseTime.toIso8601String(),
      'url': url,
      'requestBody': requestBody,
      'responseBody': responseBody,
      'requestHeaders': requestHeaders,
      'responseHeaders': responseHeaders,
      'method': method,
    };
  }

  // ignore: public_member_api_docs
  String toEncodedJson() {
    final json = {
      'statusCode': statusCode,
      'requestTime': requestTime.toIso8601String(),
      'responseTime': responseTime.toIso8601String(),
      'url': url,
      'requestBody': requestBody,
      'responseBody': responseBody,
      'requestHeaders': requestHeaders,
      'responseHeaders': responseHeaders,
      'method': method,
    };
    return dart_convert.jsonEncode(json);
  }

  dart_convert.JsonEncoder get _encoder => dart_convert.JsonEncoder.withIndent(' ' * 2);

  // ignore: public_member_api_docs
  String get requestHeadersFormatted {
    return _encoder.convert(requestHeaders);
  }

  // ignore: public_member_api_docs
  String get responseHeadersFormatted {
    return _encoder.convert(responseHeaders);
  }

  // ignore: public_member_api_docs
  String get requestBodyFormatted {
    return _encoder.convert(requestBody);
  }

  // ignore: public_member_api_docs
  String get responseBodyFormatted {
    return _encoder.convert(responseBody);
  }

  // ignore: public_member_api_docs
  String get formattedPresentation {
    return _encoder.convert(toJson());
  }
}
