import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:generic_shop_app_demo/demo.dart';

export 'package:generic_shop_app_architecture/arch.dart';

export 'src/services/_services.dart';

/// Generic Shop App Demo Plugin.
///
/// The class implementes resources required for the plugin to function.
///
class GsdPlugin extends GsaPlugin {
  /// Constructs a demo / mock plugin instance.
  ///
  GsdPlugin();

  @override
  final GsaPluginClient client = GsaPluginClient.demo;

  @override
  final String id = 'generic_shop_app_demo';

  @override
  final GsaPluginFeatures features = GsaPluginFeatures(
    authentication: false,
  );

  @override
  final GsaPluginRoutes routes = GsaPluginRoutes(
    values: [],
    initialRoute: (context) {
      return const GsaRouteShop();
    },
  );

  @override
  final GsaPluginCookies enabledCookieTypes = GsaPluginCookies(
    functional: true,
    marketing: true,
    statistical: true,
  );

  @override
  final GsaPluginTheme theme = GsaPluginTheme(
    fontFamily: 'packages/generic_shop_app_content/Quicksand',
  );

  @override
  final GsaPluginServices services = GsaPluginServices(
    values: [
      GsdServiceMock.instance,
    ],
  );

  @override
  final GsaPluginDocuments documentUrls = GsaPluginDocuments(
    termsAndConditions: 'https://ljmatan.github.io/static/example/terms-and-conditions.html',
    privacyPolicy: 'https://ljmatan.github.io/static/example/privacy-policy.html',
    cookieNotice: 'https://ljmatan.github.io/static/example/cookie-agreement.html',
  );

  @override
  final GsaPluginApi api = GsaPluginApi(
    getPromoBanners: () async {
      final images = <Uint8List>[
        for (int i = 0; i < 2; i++)
          (await rootBundle.load(
            'packages/generic_shop_app_demo/assets/demo/banner_$i.jpg',
          ))
              .buffer
              .asUint8List(),
      ];
      return [
        for (final promoEntry in {
          (
            label: 'Happiness in Your Hands',
            description: 'Fast, simple, and beautiful shopping. Try out the demo experience now.',
          ),
          (
            label: 'Delight in Every Tap',
            description: 'A showcase of how modern apps make shopping intuitive, joyful, and always within reach.',
          ),
        }.indexed)
          GsaModelPromoBanner(
            label: promoEntry.$2.label,
            description: promoEntry.$2.description,
            contentUrl: null,
            photoUrl: null,
            photoBase64: base64Encode(images[promoEntry.$1]),
          ),
      ];
    },
  );
}
