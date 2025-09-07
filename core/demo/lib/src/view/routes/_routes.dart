import 'package:generic_shop_app_demo/demo.dart';

export 'package:generic_shop_app_architecture/arch.dart';

export 'components/route_components.dart';
export 'dashboard/route_dashboard.dart';
export 'preview/route_preview.dart';

/// Collection of Route objects implemented by the "Generic Shop App" project.
///
enum GsdRoutes implements GsaRouteType {
  components,
  dashboard,
  preview;

  @override
  GsaRoute Function([dynamic args]) get widget {
    switch (this) {
      case GsdRoutes.components:
        return ([args]) => const GsdRouteComponents();
      case GsdRoutes.dashboard:
        return ([args]) => const GsdRouteComponents();
      case GsdRoutes.preview:
        return ([args]) => const GsdRoutePreview();
    }
  }

  @override
  Type get routeRuntimeType {
    switch (this) {
      case GsdRoutes.components:
        return GsdRouteComponents;
      case GsdRoutes.dashboard:
        return GsdRouteDashboard;
      case GsdRoutes.preview:
        return GsdRoutePreview;
    }
  }

  @override
  String? get routeIdPrefix => 'gsd';

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
abstract class GsdRoute extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsdRoute({super.key});

  @override
  GsaRouteType get routeType {
    return GsdRoutes.values.firstWhere(
      (route) => route.routeRuntimeType == runtimeType,
    );
  }
}
