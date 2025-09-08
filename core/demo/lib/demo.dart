import 'package:generic_shop_app_demo/demo.dart';

export 'package:generic_shop_app_architecture/arch.dart';

export 'src/services/_services.dart';
export 'src/view/_view.dart';

/// Generic Shop App Demo Plugin.
///
/// The class implementes resources required for the plugin to function.
///
class GsdPlugin extends GsaPlugin {
  /// Constructs a demo / mock plugin instance.
  ///
  const GsdPlugin({
    super.key,
    required super.child,
  });

  @override
  GsaPluginClient get client {
    return GsaPluginClient.demo;
  }

  @override
  String get id {
    return 'generic_shop_app_demo';
  }

  @override
  GsaPluginRoutes get routes {
    return GsaPluginRoutes(
      values: GsdRoutes.values,
      initialRoute: () => GsdRouteDashboard(),
    );
  }

  @override
  GsaPluginCookies get enabledCookieTypes {
    return GsaPluginCookies(
      functional: true,
      marketing: true,
      statistical: true,
    );
  }
}
