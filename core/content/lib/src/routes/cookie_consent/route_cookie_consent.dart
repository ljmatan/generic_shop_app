import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Route displaying user privacy policy and terms and conditions consent.
///
class GsaRouteCookieConsent extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteCookieConsent({super.key});

  @override
  State<GsaRouteCookieConsent> createState() => _GsaRouteCookieConsentState();
}

class _GsaRouteCookieConsentState extends GsaRouteState<GsaRouteCookieConsent> {
  @override
  Widget view(BuildContext context) {
    return const Scaffold(
      body: GsaWidgetCookieConsent(),
    );
  }
}
