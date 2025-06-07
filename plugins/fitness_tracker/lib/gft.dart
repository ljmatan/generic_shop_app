import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_fitness_tracker/gft.dart';

export 'src/view/_view.dart';

/// Generic Shop App Fitness Tracker.
///
class Gft implements GsaPlugin {
  const Gft._();

  /// Globally-accessible class instance.
  ///
  static const instance = Gft._();

  @override
  Future<void> init() async {
    // Do nothing.
  }

  @override
  Widget Function() get initialRoute {
    return () => const GftRouteSplash();
  }

  @override
  List<GsaRouteType> get routes => GftRoutes.values;

  @override
  ({
    String? fontFamily,
    Color? primary,
    Color? secondary,
    Color? tertiary,
  })? get themeProperties => (
        fontFamily: 'Open Sans',
        primary: const Color(0xff10467c),
        secondary: const Color(0xff303945),
        tertiary: const Color(0xffF6F9FC),
      );
}
