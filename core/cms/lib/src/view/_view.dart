import 'package:generic_shop_app_cms/cms.dart';

export 'dashboard/route_dashboard.dart';
export 'dashboard/pages/components/page_components.dart';
export 'dashboard/pages/preview/page_preview.dart';
export 'dashboard/pages/routes/page_routes.dart';

/// Collection of Route objects implemented by the "Generic Shop App CMS" project.
///
enum GscRoutes implements GsaRouteType {
  dashboard;

  @override
  GsaRoute Function([dynamic args]) get widget {
    switch (this) {
      case GscRoutes.dashboard:
        return ([args]) {
          return const GscRouteDashboard();
        };
    }
  }

  @override
  Type get routeRuntimeType {
    switch (this) {
      case GscRoutes.dashboard:
        return GscRouteDashboard;
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
abstract class GscRoute extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GscRoute({super.key});

  @override
  GsaRouteType get routeType {
    return GscRoutes.values.firstWhere(
      (route) {
        return route.routeRuntimeType == runtimeType;
      },
    );
  }
}
