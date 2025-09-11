import 'package:generic_shop_app_cms/cms.dart';

export 'package:generic_shop_app_architecture/arch.dart';
import 'package:generic_shop_app_demo/demo.dart';
import 'package:generic_shop_app_fitness_tracker/fitness_tracker.dart';
import 'package:generic_shop_app_froddo_b2b/froddo_b2b.dart';
import 'package:generic_shop_app_froddo_b2c/froddo_b2c.dart';

export 'src/services/_services.dart';
export 'src/view/_view.dart';

class GscPlugin extends GsaPlugin {
  @override
  final GsaPluginClient client = GsaPluginClient.cms;

  @override
  final String id = 'generic_shop_app_cms';

  @override
  GsaPluginCookies get enabledCookieTypes {
    return GsaPluginCookies(
      functional: false,
      marketing: false,
      statistical: false,
    );
  }

  @override
  GsaPluginRoutes get routes {
    return GsaPluginRoutes(
      values: GscRoutes.values,
      initialRoute: (context) {
        final appState = context.findAncestorStateOfType<GsaState>();
        if (appState == null) {
          throw Exception(
            'App state GsaState not found.',
          );
        }
        final navigatorKey = appState.widget.navigatorKey;
        if (navigatorKey != null) {
          return const GscRouteDashboard();
        } else {
          return GsaRoutes.values.first.widget();
        }
      },
    );
  }

  @override
  final GsaPluginTheme theme = GsaPluginTheme(
    fontFamily: 'packages/generic_shop_app_content/Quicksand',
  );

  @override
  final GsaPluginServices services = GsaPluginServices(
    values: [
      GsdServiceOpenFile.instance,
    ],
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
