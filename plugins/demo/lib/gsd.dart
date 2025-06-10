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
class GsdPlugin implements GsaPlugin {
  const GsdPlugin._();

  /// Globally-accessible class instance.
  ///
  static const instance = GsdPlugin._();

  @override
  Future<void> init() async {
    await GsaServiceCache.instance.clearData();
  }

  @override
  String get id {
    return 'generic_shop_app_demo';
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
  ({
    String? cookieNotice,
    String? helpAndFaq,
    String? privacyPolicy,
    String? termsAndConditions,
  })? get documentUrls {
    return null;
  }
}
