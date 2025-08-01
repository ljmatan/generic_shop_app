import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_fitness_tracker/gft.dart';
import 'package:generic_shop_app_services/services.dart';

export 'package:generic_shop_app_content/gsac.dart';

export 'src/view/_view.dart';

/// Generic Shop App Fitness Tracker.
///
class GftPlugin extends GsaPlugin {
  GftPlugin._();

  /// Globally-accessible class instance.
  ///
  static final instance = GftPlugin._();

  @override
  GsaClient get client {
    return GsaClient.fitnessTracker;
  }

  @override
  String get id {
    return 'generic_shop_app_fitness_tracker';
  }

  @override
  Future<void> init() async {
    // Do nothing.
  }

  @override
  GsaRoute Function() get initialRoute {
    return () => const GftRouteSplash();
  }

  @override
  List<GsaRouteType> get routes {
    return GftRoutes.values;
  }

  @override
  String? get fontFamily {
    return 'packages/$id/Open Sans';
  }

  @override
  String? get logoImagePath {
    return null;
  }

  @override
  Color? get primaryColor {
    return const Color(0xff10467c);
  }

  @override
  List<List<GsaServiceI18NBaseTranslations>> get translations {
    return [];
  }
}
