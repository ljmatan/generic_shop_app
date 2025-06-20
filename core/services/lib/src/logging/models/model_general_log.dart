part of '../service_logging.dart';

/// Model class defining the general app log data structure.
///
class GsaServiceLoggingModelAppLog {
  const GsaServiceLoggingModelAppLog._({
    required this.time,
    required this.message,
    required this.package,
    required this.fileName,
    required this.className,
    required this.method,
    required this.line,
    required this.callerFrames,
  });

  final DateTime time;

  final String message;

  final String? package;

  final String? fileName;

  final String? className;

  final String? method;

  final int? line;

  final List<
      ({
        String? package,
        String? source,
        String? className,
        String? method,
      })>? callerFrames;

  factory GsaServiceLoggingModelAppLog.fromStackTrace(String message) {
    final stackTrace = GsaServiceDebug.instance.getStackTrace();
    return GsaServiceLoggingModelAppLog._(
      time: DateTime.now(),
      message: message,
      package: stackTrace.package,
      fileName: stackTrace.fileName,
      className: stackTrace.className,
      method: stackTrace.method,
      line: stackTrace.line,
      callerFrames: stackTrace.callerTraces
          ?.map(
            (callerTrace) => (
              package: callerTrace.package,
              source: callerTrace.source.split('(').last.split(')').first.replaceAll('package:', ''),
              className: callerTrace.className,
              method: callerTrace.method,
            ),
          )
          .toList(),
    );
  }

  ///
  ///
  factory GsaServiceLoggingModelAppLog.fromJson(Map<String, dynamic> json) {
    return GsaServiceLoggingModelAppLog._(
      time: DateTime.parse(json['time']),
      message: json['message'],
      package: json['package'],
      fileName: json['fileName'],
      className: json['className'],
      method: json['method'],
      line: json['line'],
      callerFrames: (json['callerFrames'] as Iterable?)
          ?.map(
            (stackTraceJson) => (
              package: stackTraceJson['package'] as String?,
              source: stackTraceJson['source'] as String?,
              className: stackTraceJson['className'] as String?,
              method: stackTraceJson['method'] as String?,
            ),
          )
          .toList(),
    );
  }

  ///
  ///
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'time': time.toIso8601String(),
      'message': message,
      'package': package,
      'fileName': fileName,
      'className': className,
      'method': method,
      'line': line,
      'callerFrames': callerFrames
          ?.map(
            (stackTrace) => {
              'package': stackTrace.package,
              'source': stackTrace.source,
              'className': stackTrace.className,
              'method': stackTrace.method,
            },
          )
          .toList(),
    };
  }

  ///
  ///
  String get formattedPresentation {
    return dart_convert.JsonEncoder.withIndent(' ' * 2).convert(toJson());
  }
}
