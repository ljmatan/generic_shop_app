import 'dart:convert' as dart_convert;

import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

part 'models/model_error_log.dart';
part 'models/model_general_log.dart';

/// Session logging services, extending to general, error, or network logs.
///
class GsaServiceLogging extends GsaService {
  GsaServiceLogging._();

  static final _instance = GsaServiceLogging._();

  // ignore: public_member_api_docs
  static GsaServiceLogging get instance => _instance() as GsaServiceLogging;

  bool? _enabled;

  @override
  bool get enabled => _enabled != false;

  /// Collection of logs generated during the current runtime instance.
  ///
  final logs = (
    general: <GsaServiceLoggingModelGeneralLog>[],
    error: <GsaServiceLoggingModelErrorLog>[],
  );

  void _logGeneral(GsaServiceLoggingModelGeneralLog log) {
    logs.general.add(log);
  }

  void _logError(GsaServiceLoggingModelErrorLog log) {
    logs.error.add(log);
  }

  /// Logs any given message.
  ///
  static void logGeneral(String message) {
    try {
      // TODO: Fix
      // final stackTrace = GsaServiceDebug.instance.getStackTrace();
      final log = GsaServiceLoggingModelGeneralLog._(
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
      // final stackTrace = GsaServiceDebug.instance.getStackTrace();
      final log = GsaServiceLoggingModelErrorLog._(
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

  Future<void> init() async {
    await super.init();
    FlutterError.onError = (details) {
      print('Flutter error $details');
    };
    PlatformDispatcher.instance.onError = (details, stackTrace) {
      print('Platform error $details');
      return true;
    };
  }
}
