import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Route displaying user privacy policy and terms and conditions consent.
///
class GsaRouteLegalConsent extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteLegalConsent({super.key});

  @override
  State<GsaRouteLegalConsent> createState() => _GsaRouteLegalConsentState();
}

class _GsaRouteLegalConsentState extends GsaRouteState<GsaRouteLegalConsent> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GsaWidgetLegalConsent(),
    );
  }
}
