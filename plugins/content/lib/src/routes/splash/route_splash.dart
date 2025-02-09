import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_ivancica/api/api.dart';
import 'package:generic_shop_app_services/services.dart';

/// Route dislaying all of the logged information, implemented for debugging purposes.
///
class GsaRouteSplash extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteSplash({super.key});

  @override
  GsaRouteState<GsaRouteSplash> createState() => _GsaRouteSplashState();
}

class _GsaRouteSplashState extends GsaRouteState<GsaRouteSplash> {
  /// Defines whether the application content is ready for initialisation and display.
  ///
  bool _readyToInitialise = GsaServiceConsent.instance.hasMandatoryConsent;

  /// Function implemented for application runtime memory setup.
  ///
  Future<void> _initialise() async {
    switch (GsaConfig.provider) {
      case GsaConfigProvider.demo:
        throw UnimplementedError();
      case GsaConfigProvider.woocommerce:
        throw UnimplementedError();
      case GsaConfigProvider.ivancica:
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
    Future.delayed(
      Duration.zero,
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return GsaConfig.requiresAuthentication && !GsaDataUser.instance.authenticated ? const GsaRouteLogin() : const GsaRouteShop();
            },
          ),
        );
      },
    );
    return;
  }

  /// Property holding the [Future] state of the [_initialise] method.
  ///
  late Future<void> _initialiser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await GsaWidgetOverlayConsent.open();
        setState(
          () {
            _readyToInitialise = true;
            _initialiser = _initialise();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_readyToInitialise) return const SizedBox();
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initialiser,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return GsaWidgetError(
              snapshot.error.toString(),
              retry: () {
                setState(() => _initialiser = _initialise());
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
