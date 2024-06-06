part of '../service_logging.dart';

/// Model class defining the general app log data structure.
///
class GsaaServiceLoggingModelGeneralLog {
  const GsaaServiceLoggingModelGeneralLog._({
    required this.time,
    required this.message,
    required this.package,
    required this.className,
    required this.method,
    required this.callerFrames,
  });

  ///
  ///
  final DateTime time;

  ///
  ///
  final String message;

  ///
  ///
  final String? package;

  ///
  ///
  final String? className;

  ///
  ///
  final String? method;

  ///
  ///
  final List<({String? package, String? className, String? method})>? callerFrames;

  ///
  ///
  factory GsaaServiceLoggingModelGeneralLog.fromJson(Map<String, dynamic> json) {
    return GsaaServiceLoggingModelGeneralLog._(
      time: DateTime.parse(json['time']),
      message: json['message'],
      package: json['package'],
      className: json['className'],
      method: json['method'],
      callerFrames: (json['callerFrames'] as Iterable?)
          ?.map(
            (stackTraceJson) => (
              package: stackTraceJson['package'] as String?,
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
      'className': className,
      'method': method,
      'callerFrames': callerFrames
          ?.map(
            (stackTrace) => {
              'package': stackTrace.package,
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
