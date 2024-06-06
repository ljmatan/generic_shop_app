part of '../service_logging.dart';

/// Model class defining the network log data structure.
///
class GsaaServiceLoggingModelNetworkLog {
  const GsaaServiceLoggingModelNetworkLog._({
    required this.statusCode,
    required this.requestTime,
    required this.responseTime,
    required this.url,
    required this.host,
    required this.endpoint,
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
  final String url, host, endpoint;

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
  factory GsaaServiceLoggingModelNetworkLog.fromJson(Map<String, dynamic> json) {
    return GsaaServiceLoggingModelNetworkLog._(
      statusCode: json['statusCode'] ?? -1,
      requestTime: DateTime.tryParse(json['requestTime']) ?? DateTime.now(),
      responseTime: DateTime.tryParse(json['responseTime']) ?? DateTime.now(),
      url: json['url'] ?? 'N/A',
      host: json['host'] ?? 'N/A',
      endpoint: json['endpoint'] ?? 'N/A',
      requestBody: json['requestBody'] ?? {},
      responseBody: json['responseBody'] ?? {},
      requestHeaders: Map<String, String>.from(json['requestHeaders'] ?? {}),
      responseHeaders: Map<String, String>.from(json['responseHeaders'] ?? {}),
      method: json['method'] ?? 'N/A',
    );
  }

  // ignore: public_member_api_docs
  factory GsaaServiceLoggingModelNetworkLog.fromEncodedJson(String encodedJson) {
    final Map<String, dynamic> json = dart_convert.jsonDecode(encodedJson);
    return GsaaServiceLoggingModelNetworkLog._(
      statusCode: json['statusCode'] ?? -1,
      requestTime: DateTime.tryParse(json['requestTime']) ?? DateTime.now(),
      responseTime: DateTime.tryParse(json['responseTime']) ?? DateTime.now(),
      url: json['url'] ?? 'N/A',
      host: json['host'] ?? 'N/A',
      endpoint: json['endpoint'] ?? 'N/A',
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
      'host': host,
      'endpoint': endpoint,
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
      'host': host,
      'endpoint': endpoint,
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
