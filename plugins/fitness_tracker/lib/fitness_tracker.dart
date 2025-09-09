import 'package:flutter/material.dart';
import 'package:generic_shop_app_fitness_tracker/fitness_tracker.dart';

export 'package:generic_shop_app_architecture/arch.dart';

export 'src/view/_view.dart';

/// Generic Shop App Fitness Tracker.
///
class GftPlugin extends GsaPlugin {
  /// Constructs a Generic Shop App Fitness Tracker plugin.
  ///
  const GftPlugin({
    super.key,
    required super.child,
    super.theme,
  });

  @override
  GsaPluginClient get client {
    return GsaPluginClient.fitnessTracker;
  }

  @override
  String get id {
    return 'generic_shop_app_fitness_tracker';
  }

  @override
  GsaPluginRoutes get routes {
    return GsaPluginRoutes(
      values: GftRoutes.values,
      initialRoute: (context) {
        return const GftRouteSplash();
      },
    );
  }

  @override
  GsaPluginCookies get enabledCookieTypes {
    return GsaPluginCookies(
      functional: true,
      marketing: false,
      statistical: false,
    );
  }

  @override
  GsaPluginTheme get themeData {
    return GsaPluginTheme(
      fontFamily: 'packages/$id/Open Sans',
      primaryColor: const Color(0xff10467c),
    );
  }
}
