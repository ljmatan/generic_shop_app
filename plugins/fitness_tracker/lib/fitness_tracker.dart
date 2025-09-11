import 'package:flutter/material.dart';
import 'package:generic_shop_app_fitness_tracker/fitness_tracker.dart';

export 'package:generic_shop_app_architecture/arch.dart';

export 'src/view/_view.dart';

/// Generic Shop App Fitness Tracker.
///
class GftPlugin extends GsaPlugin {
  /// Constructs a Generic Shop App Fitness Tracker plugin.
  ///
  GftPlugin();

  @override
  final GsaPluginClient client = GsaPluginClient.fitnessTracker;

  @override
  final String id = 'generic_shop_app_fitness_tracker';

  @override
  final GsaPluginRoutes routes = GsaPluginRoutes(
    values: GftRoutes.values,
    initialRoute: (context) {
      return const GftRouteSplash();
    },
  );

  @override
  final GsaPluginCookies enabledCookieTypes = GsaPluginCookies(
    functional: true,
    marketing: false,
    statistical: false,
  );

  @override
  final GsaPluginTheme theme = GsaPluginTheme(
    fontFamily: 'packages/generic_shop_app_fitness_tracker/Open Sans',
    primaryColorLight: const Color(0xff10467c),
    primaryColorDark: const Color(0xff10467c),
  );
}
