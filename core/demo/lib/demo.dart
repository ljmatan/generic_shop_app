import 'package:generic_shop_app_demo/demo.dart';
import 'package:generic_shop_app_services/services.dart';

export 'package:generic_shop_app_content/content.dart';

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
  GsaPluginClient get client {
    return GsaPluginClient.demo;
  }

  @override
  String get id {
    return 'generic_shop_app_demo';
  }

  @override
  Future<void> setupService() async {
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
  GsaPluginCookies get enabledCookieTypes {
    return GsaPluginCookies(
      functional: true,
      marketing: true,
      statistical: true,
    );
  }

  @override
  List<List<GsaServiceI18NBaseTranslations>> get translations {
    return [];
  }
}
