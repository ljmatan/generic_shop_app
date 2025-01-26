import 'package:flutter/material.dart';
import 'package:generic_shop_app/config.dart';
import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app/view/src/common/view_builder.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:gsa_architecture/gsa_architecture.dart';

@pragma('vm:entry-point')
void main() {
  runApp(const Gsa());
}

/// The default application builder, class name name standing for "**G**eneric **S**hop **A**pp".
///
class Gsa extends StatefulWidget {
  /// Entrypoint to the Flutter SDK application services,
  /// integrating a [State] object which implements the [MaterialApp] and [Navigator] widgets as root objects.
  ///
  const Gsa({super.key});

  @override
  State<Gsa> createState() => _GsaState();
}

class _GsaState extends State<Gsa> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GsarRoute.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => GsaViewBuilder(child!),
      navigatorObservers: [GsarRoute.navigatorObserver],
      home: GsaConfig.requiresAuthentication && !GsaDataUser.instance.authenticated ? const GsaRouteLogin() : const GsaRouteShop(),
      onGenerateRoute: (settings) {
        final primary = settings.name?.split('/')[0];
        return MaterialPageRoute<void>(
          builder: (BuildContext context) => switch (primary) {
            'auth' => const GsaRouteLogin(),
            'cart' => const GsaRouteCart(),
            'chat' => const GsaRouteChat(),
            'checkout' => const GsaRouteCheckout(),
            'cookie-policy' => const GsaRouteCookiePolicy(),
            'contact' => const GsaRouteMerchantContact(),
            'debug' => const GsaRouteDebug(),
            'guest-info' => const GsaRouteGuestInfo(),
            'help' => const GsaRouteHelp(),
            'licences' => const GsaRouteLicences(),
            'merchant' => const GsaRouteMerchant(),
            'onboarding' => const GsaRouteOnboarding(),
            'order-status' => const GsaRouteOrderStatus(),
            'privacy-policy' => const GsaRoutePrivacyPolicy(),
            'register' => const GsaRouteRegister(),
            'sale-item' => GsaRouteProductDetails(
                saleItem: (settings.arguments as Map?)?['saleItem'],
              ),
            'settings' => const GsaRouteSettings(),
            'shop' => const GsaRouteShop(),
            'terms-and-conditions' => const GsaRouteTermsAndConditions(),
            null || String() => throw UnimplementedError(),
          },
        );
      },
    );
  }
}
