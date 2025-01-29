import 'dart:convert' as dart_convert;

import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:http/http.dart' as http;

/// A base class for the HTTP client services.
///
abstract class GsarApi {
  /// Constant constructor definition implementation.
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

  /// Method used for validating [fields] against the values provided by the [validators].
  ///
  /// The method will return a result if any errors are detected.
  ///
  List<String>? validateFields({
    required GsarModel validators,
    required dynamic fields,
  }) {
    /// List of errors discovered during the validation process.
    ///
    final errors = <String>[];

    /// Verifies the fields against the provided values.
    ///
    void verify(Map<String, dynamic> value) {
      for (final field in validators.generateFields()) {
        final valueType = value[field.key].runtimeType;
        if (valueType != field.type) {
          errors.add('Key ${field.key} is not of type ${field.type}. Found $valueType');
        }
      }
    }

    /// Parses the provided field and calls the [verify] method on it.
    ///
    void parse(dynamic value) {
      try {
        final fields = Map<String, dynamic>.from(value);
        verify(fields);
      } catch (e) {
        errors.add('Unexpected validation error: $e');
      }
    }

    if (fields is Iterable) {
      for (final field in fields) {
        parse(field);
      }
    } else {
      parse(fields);
    }

    return errors.isEmpty ? null : errors;
  }
}

/// Supported types of HTTP network requests.
///
enum GsarApiEndpointMethodType {
  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET
  ///
  httpGet,

  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/POST
  ///
  httpPost,

  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PATCH
  ///
  httpPatch,

  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PUT
  ///
  httpPut,

  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE
  ///
  httpDelete;

  /// Human-readable method identifier.
  ///
  String get id {
    switch (this) {
      case GsarApiEndpointMethodType.httpGet:
        return 'GET';
      case GsarApiEndpointMethodType.httpPost:
        return 'POST';
      case GsarApiEndpointMethodType.httpPatch:
        return 'PATCH';
      case GsarApiEndpointMethodType.httpPut:
        return 'PUT';
      case GsarApiEndpointMethodType.httpDelete:
        return 'DELETE';
    }
  }
}

/// Class defining main endpoint fields for subsequent implementations.
///
/// The object can be used as in below example:
///
/// ```dart
/// enum ExampleEnum implements GsarApiEndpoints {
///   example;
///
///   @override
///   String get path {
///     switch (this) {
///       case ExampleEnum.example:
///         return 'example';
///     }
///   }
///
///   @override
///   GsarApiEndpointMethodType get method {
///     switch (this) {
///       case ExampleEnum.example:
///         return GsarApiEndpointMethodType.httpGet;
///     }
///   }
/// }
/// ```
///
/// In the above example, endpoint properties are defined by inheritance.
///
abstract class GsarApiEndpoints {
  /// URL path of the network resource.
  ///
  String get path;

  /// Method type defined for the specified endpoint.
  ///
  GsarApiEndpointMethodType get method;

  /// Endpoint field definitions, used to define the request fields.
  ///
  GsarModel? get requestFields;

  /// Endpoint field definitions, used to define the response fields.
  ///
  GsarModel? get responseFields;
}

/// Model class defining the network log data structure.
///
class GsarApiModelLog {
  /// Default unnamed class constructor.
  ///
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
