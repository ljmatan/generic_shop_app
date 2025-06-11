import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_ivancica/giv.dart';

export 'src/api/_api.dart';
export 'src/endpoints/_endpoints.dart';
export 'src/models/_models.dart';
export 'src/view/_view.dart';

/// Generic Shop App Ivancica.
///
class GivPlugin implements GsaPlugin {
  const GivPlugin._();

  /// Globally-accessible class instance.
  ///
  static const instance = GivPlugin._();

  @override
  String get id {
    return 'generic_shop_app_ivancica';
  }

  @override
  Future<void> init() async {
    GsaDataMerchant.instance.merchant = GsaModelMerchant(
      name: 'froddo',
      contact: GsaModelContact(
        email: 'web.shop@ivancica.hr',
        phoneCountryCode: '+385',
        phoneNumber: '42 402 271',
      ),
    );
    final products = await GivApiProducts.instance.getProducts();
    GsaDataSaleItems.instance.products.addAll(products);
  }

  @override
  GsaRoute Function() get initialRoute {
    return () {
      return const GsaRouteShop();
    };
  }

  @override
  List<GsaRouteType>? get routes {
    return GivRoutes.values;
  }

  @override
  String? get fontFamily {
    return 'packages/$id/Merriweather Sans';
  }

  @override
  String? get logoImagePath {
    return 'packages/$id/assets/ivancica/svg/logo.svg';
  }

  @override
  Color? get primaryColor {
    return const Color(0xff8DC63F);
  }

  @override
  ({
    String? cookieNotice,
    String? helpAndFaq,
    String? privacyPolicy,
    String? termsAndConditions,
  })? get documentUrls {
    return null;
  }
}
