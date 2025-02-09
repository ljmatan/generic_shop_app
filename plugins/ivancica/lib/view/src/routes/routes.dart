// ignore_for_file: public_member_api_docs

import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_ivancica/view/src/routes/product_details/route_product_details.dart';

/// Collection of Route objects implemented by the "Generic Shop App" project.
///
enum GivRoutes implements GsaRouteType {
  productDetails;

  @override
  Type get routeRuntimeType {
    switch (this) {
      case GivRoutes.productDetails:
        return GivRouteSaleItemDetails;
    }
  }

  @override
  String get routeId {
    switch (this) {
      default:
        return name.replaceAllMapped(
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
abstract class GivRoute extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GivRoute({super.key});

  @override
  GsaRouteType get routeType {
    return GivRoutes.values.firstWhere(
      (route) => route.routeRuntimeType == runtimeType,
    );
  }
}
