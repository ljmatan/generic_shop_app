import 'dart:convert' as dart_convert;

import 'package:generic_shop_app_api/src/services/services.dart';

part 'models/model_error_log.dart';
part 'models/model_general_log.dart';
part 'models/model_network_log.dart';

/// Session logging services, extending to general, error, or network logs.
///
class GsaaServiceLogging extends GsaaService {
  GsaaServiceLogging._();

  static final _instance = GsaaServiceLogging._();

  // ignore: public_member_api_docs
  static GsaaServiceLogging get instance => _instance() as GsaaServiceLogging;

  bool? _enabled;

  @override
  bool get enabled => _enabled != false;

  /// Collection of logs generated during the current runtime instance.
  ///
  final logs = (
    general: <GsaaServiceLoggingModelGeneralLog>[],
    error: <GsaaServiceLoggingModelErrorLog>[],
    network: <GsaaServiceLoggingModelNetworkLog>[],
  );

  void _logGeneral(GsaaServiceLoggingModelGeneralLog log) {
    logs.general.add(log);
  }

  void _logError(GsaaServiceLoggingModelErrorLog log) {
    logs.error.add(log);
  }

  void _logNetworkRequest(GsaaServiceLoggingModelNetworkLog log) {
    logs.network.add(log);
  }

  /// Logs any given message.
  ///
  static void logGeneral(String message) {
    try {
      // TODO: Fix
      // final stackTrace = GsaaServiceDebug.instance.getStackTrace();
      final log = GsaaServiceLoggingModelGeneralLog._(
        time: DateTime.now(),
        message: message,
        package: null,
        className: null,
        method: null,
        callerFrames: [],
        // package: stackTrace.package,
        // className: stackTrace.className,
        // method: stackTrace.method,
        // callerFrames: stackTrace.callerFrames
        //     .map(
        //       (frame) => (
        //         package: frame.package,
        //         className: frame.className,
        //         method: frame.method,
        //       ),
        //     )
        //     .toList(),
      );
      instance._logGeneral(log);
    } catch (e) {
      // Do nothing, service is disabled.
    }
  }

  /// Method aimed at logging error messages.
  ///
  static void logError(String message) {
    try {
      // TODO: Fix
      // final stackTrace = GsaaServiceDebug.instance.getStackTrace();
      final log = GsaaServiceLoggingModelErrorLog._(
        time: DateTime.now(),
        message: message,
        package: null,
        className: null,
        method: null,
        callerFrames: [],
        // package: stackTrace.package,
        // className: stackTrace.className,
        // method: stackTrace.method,
        // callerFrames: stackTrace.callerFrames
        //     .map(
        //       (frame) => (
        //         package: frame.package,
        //         className: frame.className,
        //         method: frame.method,
        //       ),
        //     )
        //     .toList(),
      );
      instance._logError(log);
    } catch (e) {
      // Do nothing, service is disabled.
    }
  }

  /// Method provided for logging network requests made from the app.
  ///
  static void logNetworkRequest({
    required int statusCode,
    required DateTime requestTime,
    required Uri uri,
    required String method,
    required Map<String, String> requestHeaders,
    required Map<String, dynamic> requestBody,
    required Map<String, String> responseHeaders,
    required Map<String, dynamic> responseBody,
  }) {
    try {
      final log = GsaaServiceLoggingModelNetworkLog._(
        statusCode: statusCode,
        requestTime: requestTime,
        responseTime: DateTime.now(),
        method: method,
        url: uri.toString(),
        host: uri.host,
        endpoint: uri.path,
        requestBody: requestHeaders,
        responseBody: responseBody,
        requestHeaders: requestHeaders,
        responseHeaders: responseHeaders,
      );
      instance._logNetworkRequest(log);
    } catch (e) {
      // Do nothing, service is disabled.
    }
  }
}
