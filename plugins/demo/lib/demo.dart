import 'package:generic_shop_app_demo/demo.dart';
import 'package:generic_shop_app_fitness_tracker/fitness_tracker.dart';
import 'package:generic_shop_app_froddo_b2b/froddo_b2b.dart';
import 'package:generic_shop_app_froddo_b2c/froddo_b2c.dart';

export 'package:generic_shop_app_architecture/arch.dart';

export 'src/services/_services.dart';

/// Generic Shop App Demo Plugin.
///
/// The class implementes resources required for the plugin to function.
///
class GsdPlugin extends GsaPlugin {
  /// Constructs a demo / mock plugin instance.
  ///
  GsdPlugin();

  @override
  final GsaPluginClient client = GsaPluginClient.demo;

  @override
  final String id = 'generic_shop_app_demo';

  @override
  final GsaPluginFeatures features = GsaPluginFeatures(
    authentication: false,
  );

  @override
  final GsaPluginRoutes routes = GsaPluginRoutes(
    values: [],
    initialRoute: (context) {
      return const GsaRouteShop();
    },
  );

  @override
  final GsaPluginCookies enabledCookieTypes = GsaPluginCookies(
    functional: true,
    marketing: true,
    statistical: true,
  );

  @override
  final GsaPluginTheme theme = GsaPluginTheme(
    fontFamily: 'packages/generic_shop_app_fitness_tracker/Open Sans',
  );

  @override
  final GsaPluginServices services = GsaPluginServices(
    values: [
      GsdServiceMock.instance,
    ],
  );

  @override
  final GsaPluginDocuments documentUrls = GsaPluginDocuments(
    termsAndConditions: 'https://ljmatan.github.io/static/example/terms-and-conditions.html',
    privacyPolicy: 'https://ljmatan.github.io/static/example/privacy-policy.html',
    cookieNotice: 'https://ljmatan.github.io/static/example/cookie-agreement.html',
  );
}
