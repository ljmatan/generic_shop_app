import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_demo/gsd.dart';
import 'package:generic_shop_app_services/services.dart';

export 'src/services/_services.dart';
export 'src/view/_view.dart';

/// Generic Shop App Demo Plugin.
///
/// The class implementes resources required for the plugin to function.
///
class GsdPlugin extends GsaPlugin {
  GsdPlugin._();

  /// Globally-accessible class instance.
  ///
  static final instance = GsdPlugin._();

  @override
  GsaClient get client {
    return GsaClient.demo;
  }

  @override
  String get id {
    return 'generic_shop_app_demo';
  }

  @override
  Future<void> init() async {
    await GsaServiceCache.instance.clearData();
  }

  @override
  GsaRoute Function() get initialRoute {
    return () => const GsdRoutePreview();
  }

  @override
  List<GsaRouteType>? get routes {
    return null;
  }

  @override
  String? get fontFamily {
    return null;
  }

  @override
  String? get logoImagePath {
    return null;
  }

  @override
  Color? get primaryColor {
    return null;
  }

  @override
  List<List<GsaServiceI18NBaseTranslations>> get translations {
    return [];
  }
}
