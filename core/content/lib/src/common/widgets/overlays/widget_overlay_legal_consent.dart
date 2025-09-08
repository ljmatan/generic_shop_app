import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Widget overlay displaying user privacy policy and terms and conditions consent.
///
class GsaWidgetOverlayConsent extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlayConsent({
    super.key,
  });

  @override
  bool get barrierDismissible => GsaServiceConsent.instance.hasMandatoryConsent;

  @override
  State<GsaWidgetOverlayConsent> createState() => _GsaWidgetOverlayConsentState();
}

class _GsaWidgetOverlayConsentState extends State<GsaWidgetOverlayConsent> {
  @override
  Widget build(BuildContext context) {
    return GsaWidgetCookieConsent(
      plugin: GsaPlugin.of(context),
    );
  }
}
