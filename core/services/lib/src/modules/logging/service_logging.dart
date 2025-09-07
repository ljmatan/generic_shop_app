import 'dart:convert' as dart_convert;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';
import 'package:generic_shop_app_services/services.dart';

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
    general: <GsaServiceLoggingModelAppLog>[],
    error: <GsaServiceLoggingModelAppLog>[],
    method: <GsaServiceLoggingModelAppLog>[],
  );

  /// Logs any given message.
  ///
  void logGeneral(
    String message, {
    StackTrace? parentStackTrace,
  }) {
    try {
      final log = GsaServiceLoggingModelAppLog.fromStackTrace(message);
      logs.general.add(log);
      if (kDebugMode) print('New log:\n${log.message}');
    } catch (e) {
      // Do nothing, service is disabled.
    }
  }

  /// Method aimed at logging error messages.
  ///
  void logError(
    String message, {
    StackTrace? parentStackTrace,
  }) {
    try {
      final log = GsaServiceLoggingModelAppLog.fromStackTrace(message);
      logs.error.add(log);
      if (kDebugMode) print('An error occurred:\n${log.message}');
    } catch (e) {
      // Do nothing, service is disabled.
    }
  }

  /// Method implement for logging any app method calls.
  ///
  void logMethod() {
    try {
      final log = GsaServiceLoggingModelAppLog.fromStackTrace(null);
      logs.method.add(log);
    } catch (e) {
      // Do nothing, service is disabled.
    }
  }

  Future<void> init() async {
    await super.init();
    final defaultErrorWidgetBuilder = ErrorWidget.builder;
    ErrorWidget.builder = (details) {
      StackTrace? parentStackTrace;
      try {
        parentStackTrace = (details.exception as Error).stackTrace;
      } catch (e) {
        // Do nothing.
      }
      parentStackTrace ??= details.stack;
      logError(
        details.summary.toString(),
        parentStackTrace: parentStackTrace,
      );
      return defaultErrorWidgetBuilder(details);
    };
    final defaultFlutterErrorHandler = FlutterError.onError;
    FlutterError.onError = (details) {
      StackTrace? parentStackTrace;
      try {
        parentStackTrace = (details.exception as Error).stackTrace;
      } catch (e) {
        // Do nothing.
      }
      parentStackTrace ??= details.stack;
      logError(
        '${details.exception}',
        parentStackTrace: parentStackTrace,
      );
      if (defaultFlutterErrorHandler != null) {
        return defaultFlutterErrorHandler(details);
      }
    };
    final defaultPlatformDispatcherErrorHandler = PlatformDispatcher.instance.onError;
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      logError(
        '$error',
        parentStackTrace: stackTrace,
      );
      return defaultPlatformDispatcherErrorHandler == null ? false : defaultPlatformDispatcherErrorHandler(error, stackTrace);
    };
    debugPrint = (
      message, {
      wrapWidth,
    }) {
      message ??= 'No message provided.';
      if (wrapWidth == -1) {
        logError(message);
      } else {
        logGeneral(message);
      }
      if (kDebugMode) print(message);
    };
  }
}
