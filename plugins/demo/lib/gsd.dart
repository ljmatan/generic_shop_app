import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_demo/gsd.dart';

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
    await GsdServiceMock.instance.init();
  }

  @override
  Widget Function() get initialRoute {
    return () => const GsdRoutePreview();
  }

  @override
  List<GsaRouteType> get routes => GsdRoutes.values;

  @override
  ({
    String? fontFamily,
    Color? primary,
    Color? secondary,
    Color? tertiary,
  })? get themeProperties => null;

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
