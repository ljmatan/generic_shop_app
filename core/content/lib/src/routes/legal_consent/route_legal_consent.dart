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
  });

  /// Location of the relevant web or asset resource.
  ///
  final String url;

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
