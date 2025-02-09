import 'dart:convert' as dart_convert;

import 'package:http/http.dart' as http;

/// A base class for the HTTP client services.
///
abstract class GsaApi {
  /// Constant constructor definition implementation.
  ///
  const GsaApi();

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

  /// Security token used for authentication.
  ///
  /// The token is added automatically to the [headers] field if applied,
  /// taking precedence over the [bearerTokenCredentials] value, if it's also provided.
  ///
  String? get bearerToken => null;

  /// A set of credentials for bearer token authentication.
  ///
  /// These credentials are added automatically to the [headers] field if applied,
  /// and if [bearerToken] value is not already provided.
  ///
  ({String username, String password})? get bearerTokenCredentials => null;

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
      if (bearerToken != null || bearerTokenCredentials != null)
        'Authorization': 'Bearer ' +
            (bearerToken ??
                dart_convert.base64.encode(
                  dart_convert.utf8.encode(
                    '${bearerTokenCredentials!.username}:${bearerTokenCredentials!.password}',
                  ),
                )),
    }..addAll(additionalHeaders);
  }

  /// Maximum time allowed before a response is received from a request.
  ///
  Duration get _timeoutDuration => const Duration(seconds: 10);

  /// Logs recorded during the application runtime.
  ///
  static final logs = <GsaApiModelLog>[];

  /// Whether the logging functionality is enabled for an API subclass instance.
  ///
  bool get loggingEnabled => true;

  /// Creates a new log entry from the provided data.
  ///
  Future<void> _log(GsaApiModelLog log) async {
    if (!loggingEnabled) return;
    logs.add(log);
  }

  /// Method used for validating [fields] against the values provided by the [validators].
  ///
  /// The method will return a result if any errors are detected.
  ///
  List<String>? validateFields({
    GsaApiEndpointsFields? fieldValidators,
    List<
            ({
              String key,
              Type type,
            })>?
        validators,
    required dynamic fields,
  }) {
    if (fieldValidators == null && validators == null) {
      print('Either fieldValidators or validator property must be specified.');
      return null;
    }

    validators ??= fieldValidators?.responseFields
        ?.map(
          (fieldValidator) => (
            key: fieldValidator.key,
            type: fieldValidator.type,
          ),
        )
        .toList();

    if (validators?.isNotEmpty != true) {
      print('Property validators must not be empty.');
      return null;
    }

    /// List of errors discovered during the validation process.
    ///
    final errors = <String>[];

    /// Verifies the fields against the provided values.
    ///
    void verify(Map<String, dynamic> value) {
      for (final field in validators!) {
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
          GsaApiModelLog(
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

/// Supported types of HTTP network requests.
///
enum GsaApiEndpointMethodType {
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
}

/// Class defining main endpoint fields for subsequent implementations.
///
/// The object can be used as in below example:
///
/// ```dart
/// enum ExampleEnum implements GsaApiEndpoints {
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
///   GsaApiEndpointMethodType get method {
///     switch (this) {
///       case ExampleEnum.example:
///         return GsaApiEndpointMethodType.httpGet;
///     }
///   }
/// }
/// ```
///
/// In the above example, endpoint properties are defined by inheritance.
///
abstract mixin class GsaApiEndpoints {
  /// URL path of the network resource.
  ///
  String get path;

  /// Method type defined for the specified endpoint.
  ///
  GsaApiEndpointMethodType get method;

  /// Network request defined for this endpoint.
  ///
  Future<dynamic> request(
    GsaApi client, {
    Map<String, dynamic> body = const {},
    bool decodedResponse = true,
  }) {
    switch (method) {
      case GsaApiEndpointMethodType.httpGet:
        return client.get(
          path,
          decodedResponse: decodedResponse,
        );
      case GsaApiEndpointMethodType.httpPost:
      case GsaApiEndpointMethodType.httpPatch:
      case GsaApiEndpointMethodType.httpPut:
        switch (method) {
          case GsaApiEndpointMethodType.httpPost:
            return client.post(
              path,
              body,
              decodedResponse: decodedResponse,
            );
          case GsaApiEndpointMethodType.httpPatch:
            return client.patch(
              path,
              body,
              decodedResponse: decodedResponse,
            );
          case GsaApiEndpointMethodType.httpPut:
            return client.post(
              path,
              body,
              decodedResponse: decodedResponse,
            );
          default:
            throw 'HTTP method not implemented.';
        }
      case GsaApiEndpointMethodType.httpDelete:
        return client.delete(
          path,
          body: body,
          decodedResponse: decodedResponse,
        );
    }
  }
}

/// Endpoint input data validation methods and properties.
///
/// Such object can be implemented in order to provide detailed endpoint information:
///
/// ```dart
/// enum ExampleEnum implements GsaApiEndpointsFields {
///   exampleGet, examplePost;
///
///   List<({String key, Type type, bool isRequired})>? get fields {
///     switch (this) {
///       case ExampleEnum.examplePost:
///         return [
///           ...
///         ];
///       default:
///         return null;
///     }
///   }
/// }
/// ```
///
/// This information can both be used for field validation and for documentation generation.
///
abstract class GsaApiEndpointsFields {
  /// Specified list of fields and their associated runtime types,
  /// referenced during the validation process.
  ///
  List<
      ({
        String key,
        Type type,
        bool isRequired,
      })>? get requestFields;

  /// Specified list of fields and their associated runtime types,
  /// referenced during the validation process.
  ///
  List<
      ({
        String key,
        Type type,
      })>? get responseFields;
}

/// Model class defining the network log data structure.
///
class GsaApiModelLog {
  /// Default unnamed class constructor.
  ///
  const GsaApiModelLog({
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

  /// Method used for the formatting of [DateTime] objects.
  ///
  String _timeFormatted(
    DateTime time, {
    bool numerical = true,
  }) {
    if (numerical) {
      return '${time.day < 10 ? '0${time.day}' : time.day}.'
          '${time.month < 10 ? '0${time.month}' : time.month}.'
          '${time.year}. '
          '${time.hour < 10 ? '0${time.hour}' : time.hour}:'
          '${time.minute < 10 ? '0${time.minute}' : time.minute}:'
          '${time.second < 10 ? '0${time.second}' : time.second}:'
          '${time.millisecond < 10 ? '0${time.millisecond}' : time.millisecond}';
    } else {
      throw UnimplementedError();
    }
  }

  /// Formatted display of the [requestTime] object.
  ///
  String requestTimeFormatted({
    bool numerical = true,
  }) {
    return _timeFormatted(
      requestTime,
      numerical: numerical,
    );
  }

  /// Formatted display of the [responseTime] object.
  ///
  String responseTimeFormatted({
    bool numerical = true,
  }) {
    return _timeFormatted(
      responseTime,
      numerical: numerical,
    );
  }

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
  factory GsaApiModelLog.fromJson(Map<String, dynamic> json) {
    return GsaApiModelLog(
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
  factory GsaApiModelLog.fromEncodedJson(String encodedJson) {
    final Map<String, dynamic> json = dart_convert.jsonDecode(encodedJson);
    return GsaApiModelLog(
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
