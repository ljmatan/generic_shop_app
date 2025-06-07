import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_ivancica/api/api.dart';

/// Generic Shop App Ivancica.
///
class Giv implements GsaPlugin {
  const Giv._();

  /// Globally-accessible class instance.
  ///
  static const instance = Giv._();

  @override
  Future<void> init() async {
    GsaDataMerchant.instance.merchant = GsaModelMerchant(
      name: 'froddo',
      logoImageUrl: 'assets/ivancica/logo.png',
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
  Widget Function() get initialRoute {
    return () => const GsaRouteShop();
  }

  @override
  List<GsaRouteType> get routes => GsaRoutes.values;

  @override
  ({
    String? fontFamily,
    Color? primary,
    Color? secondary,
    Color? tertiary,
  })? get themeProperties => (
        fontFamily: 'Merriweather Sans',
        primary: const Color(0xff8DC63F),
        secondary: const Color(0xff303945),
        tertiary: const Color(0xffF6F9FC),
      );
}
