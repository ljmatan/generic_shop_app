import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:generic_shop_app/services/services.dart';

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

  @override
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
