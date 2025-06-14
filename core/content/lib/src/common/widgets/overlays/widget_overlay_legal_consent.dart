import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_content/src/common/widgets/overlays/widget_overlay.dart';
import 'package:generic_shop_app_services/services.dart';

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
    return const GsaWidgetLegalConsent();
  }
}
