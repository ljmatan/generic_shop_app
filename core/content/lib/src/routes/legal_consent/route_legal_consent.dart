import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Route displaying user privacy policy and terms and conditions consent.
///
class GsaRouteLegalConsent extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteLegalConsent({
    super.key,
    required this.url,
  }) : title = 'Cookie Agreement';

  /// Constructs an instance of the screen displaying the terms and conditions.
  ///
  const GsaRouteLegalConsent.termsAndConditions({
    super.key,
    required this.url,
  }) : title = 'Terms and Conditions';

  /// Constructs an instance of the screen displaying the privacy policy.
  ///
  const GsaRouteLegalConsent.privacyPolicy({
    super.key,
    required this.url,
  }) : title = 'Privacy Policy';

  /// Constructs an instance of the screen displaying the cookie agreement.
  ///
  const GsaRouteLegalConsent.cookieAgreement({
    super.key,
    required this.url,
  }) : title = 'Cookie Agreement';

  /// Location of the relevant web or asset resource.
  ///
  final String url;

  /// User-facing title of this screen.
  ///
  final String title;

  @override
  String get displayName {
    return title;
  }

  @override
  State<GsaRouteLegalConsent> createState() => _GsaRouteLegalConsentState();
}

class _GsaRouteLegalConsentState extends GsaRouteState<GsaRouteLegalConsent> {
  @override
  Widget view(BuildContext context) {
    return GsaRouteWebView(
      url: widget.url,
      urlPath: 'urlPath',
      title: 'title',
    );
  }
}
