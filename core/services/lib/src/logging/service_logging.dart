import 'dart:convert' as dart_convert;

import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
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
  );

  void _logGeneral(GsaServiceLoggingModelAppLog log) {
    logs.general.add(log);
  }

  void _logError(GsaServiceLoggingModelAppLog log) {
    logs.error.add(log);
  }

  /// Logs any given message.
  ///
  void logGeneral(String message) {
    try {
      final log = GsaServiceLoggingModelAppLog.fromStackTrace(message);
      _logGeneral(log);
    } catch (e) {
      // Do nothing, service is disabled.
    }
  }

  /// Method aimed at logging error messages.
  ///
  void logError(String message) {
    try {
      final log = GsaServiceLoggingModelAppLog.fromStackTrace(message);
      _logError(log);
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
