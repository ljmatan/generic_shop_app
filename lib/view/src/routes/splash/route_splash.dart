import 'package:flutter/material.dart';
import 'package:generic_shop_app/config.dart';
import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_ivancica/api/api.dart';

/// Route dislaying all of the logged information, implemented for debugging purposes.
///
class GsaRouteSplash extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteSplash({super.key});

  @override
  String get routeId => 'logging';

  @override
  String get displayName => 'Logger';

  @override
  GsarRouteState<GsaRouteSplash> createState() => _GsaRouteSplashState();
}

class _GsaRouteSplashState extends GsarRouteState<GsaRouteSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: switch (GsaConfig.provider) {
          GsaConfigProvider.ivancica => Future(
              () async {
                final products = await GivApiProducts.instance.getProducts();
                GsaDataSaleItems.instance.products.addAll(products);
                GsaDataMerchant.instance.merchant = GsaaModelMerchant(
                  name: 'froddo',
                  logoImageUrl: 'assets/ivancica/logo.png',
                );
              },
            ),
          GsaConfigProvider.demo => throw UnimplementedError(),
          GsaConfigProvider.herbalife => throw UnimplementedError(),
          GsaConfigProvider.woocommerce => throw UnimplementedError(),
        }
            .then(
          (_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return GsaConfig.requiresAuthentication && !GsaDataUser.instance.authenticated
                      ? const GsaRouteLogin()
                      : const GsaRouteShop();
                },
              ),
            );
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
