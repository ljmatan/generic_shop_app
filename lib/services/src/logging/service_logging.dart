import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gsa_architecture/gsa_architecture.dart';

/// Session logging services, extending to general, error, or network logs.
///
class GsaServiceLogging extends GsarService {
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
