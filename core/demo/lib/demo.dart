import 'package:generic_shop_app_demo/demo.dart';
import 'package:generic_shop_app_fitness_tracker/fitness_tracker.dart';
import 'package:generic_shop_app_froddo_b2b/froddo_b2b.dart';
import 'package:generic_shop_app_froddo_b2c/froddo_b2c.dart';

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
  GsdPlugin();

  @override
  final GsaPluginClient client = GsaPluginClient.demo;

  @override
  final String id = 'generic_shop_app_demo';

  @override
  final GsaPluginRoutes routes = GsaPluginRoutes(
    values: GsdRoutes.values,
    initialRoute: (context) {
      final appState = context.findAncestorStateOfType<GsaState>();
      if (appState == null) {
        throw Exception(
          'App state GsaState not found.',
        );
      }
      final navigatorKey = appState.widget.navigatorKey;
      if (navigatorKey != null) {
        return const GsdRouteDashboard();
      } else {
        return GsaRoutes.values.first.widget();
      }
    },
  );

  @override
  final GsaPluginCookies enabledCookieTypes = GsaPluginCookies(
    functional: true,
    marketing: true,
    statistical: true,
  );

  /// Collection of all available plugin integrations.
  ///
  static final pluginCollection = <GsaPlugin>{
    GsdPlugin(),
    GftPlugin(),
    GfbPlugin(),
    GfcPlugin(),
  };
}
