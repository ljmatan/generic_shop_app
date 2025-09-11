import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Widget overlay displaying user privacy policy and terms and conditions consent.
///
class GsaWidgetOverlayCookieConsent extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlayCookieConsent({
    super.key,
  });

  @override
  bool get barrierDismissible => GsaServiceConsent.instance.hasMandatoryConsent;

  @override
  State<GsaWidgetOverlayCookieConsent> createState() => _GsaWidgetOverlayConsentState();
}

class _GsaWidgetOverlayConsentState extends State<GsaWidgetOverlayCookieConsent> {
  @override
  Widget build(BuildContext context) {
    return GsaWidgetCookieConsent(
      plugin: GsaPlugin.of(context),
    );
  }
}
