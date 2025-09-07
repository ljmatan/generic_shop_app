import 'package:generic_shop_app_fitness_tracker/src/view/routes/dashboard/route_dashboard.dart';
import 'package:generic_shop_app_fitness_tracker/src/view/routes/onboarding/route_onboarding.dart';
import 'package:generic_shop_app_architecture/arch.dart';
import 'package:generic_shop_app_fitness_tracker/src/view/routes/splash/route_splash.dart';

export 'package:generic_shop_app_architecture/arch.dart';

export 'dashboard/route_dashboard.dart';
export 'onboarding/route_onboarding.dart';
export 'splash/route_splash.dart';

/// Collection of Route objects implemented by the "Generic Shop App" project.
///
enum GftRoutes implements GsaRouteType {
  onboarding,
  dashboard,
  splash;

  @override
  GsaRoute Function([dynamic args]) get widget {
    switch (this) {
      case GftRoutes.onboarding:
        return ([args]) => const GftRouteOnboarding();
      case GftRoutes.dashboard:
        return ([args]) => const GftRouteDashboard();
      case GftRoutes.splash:
        return ([args]) => const GftRouteSplash();
    }
  }

  @override
  Type get routeRuntimeType {
    switch (this) {
      case GftRoutes.onboarding:
        return GftRouteOnboarding;
      case GftRoutes.dashboard:
        return GftRouteDashboard;
      case GftRoutes.splash:
        return GftRouteSplash;
    }
  }

  @override
  String? get routeIdPrefix => 'gft';

  @override
  String get routeId {
    switch (this) {
      default:
        return '$routeIdPrefix-' +
            name.replaceAllMapped(
              RegExp(r'([a-z0-9])([A-Z])'),
              (Match m) => '${m[1]}-${m[2]!.toLowerCase()}',
            );
    }
  }

  @override
  String get displayName {
    switch (this) {
      default:
        return name
            .replaceAllMapped(
              RegExp(r'([a-z0-9])([A-Z])'),
              (Match m) => '${m[1]} ${m[2]}',
            )
            .replaceFirstMapped(
              RegExp(r'^[a-z]'),
              (Match m) => m[0]!.toUpperCase(),
            );
    }
  }
}

/// A base Route class implementing the [GsaRoute] interface.
///
abstract class GftRoute extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GftRoute({super.key});

  @override
  GsaRouteType get routeType {
    return GftRoutes.values.firstWhere(
      (route) => route.routeRuntimeType == runtimeType,
    );
  }
}
