// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_ivancica/giv.dart';

export 'package:generic_shop_app_architecture/gsar.dart';

export 'product_details/route_product_details.dart';
export 'user_profile/route_user_profile.dart';

/// Collection of Route objects implemented by the "Generic Shop App" project.
///
enum GivRoutes implements GsaRouteType {
  productDetails,
  userProfile;

  @override
  GsaRoute Function([dynamic args]) get widget {
    switch (this) {
      case GivRoutes.productDetails:
        return ([args]) {
          if (args is GsaModelSaleItem) {
            return GivRouteSaleItemDetails(args);
          } else {
            throw Exception(
              'Provided type ${args.runtimeType} is not of type GsaModelSaleItem.',
            );
          }
        };
      case GivRoutes.userProfile:
        return ([args]) => const GivRouteUserProfile();
    }
  }

  @override
  Type get routeRuntimeType {
    switch (this) {
      case GivRoutes.productDetails:
        return GivRouteSaleItemDetails;
      case GivRoutes.userProfile:
        return GivRouteUserProfile;
    }
  }

  @override
  String? get routeIdPrefix => 'giv';

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
