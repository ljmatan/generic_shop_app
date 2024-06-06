import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_web_content.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';

/// Route designed for displaying of the privacy policy and related consent mechanisms.
///
class GsaRoutePrivacyPolicy extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRoutePrivacyPolicy({super.key});

  @override
  State<GsaRoutePrivacyPolicy> createState() => _GsaRoutePrivacyPolicyState();

  @override
  String get routeId => 'privacy-policy';

  @override
  String get displayName => 'Privacy Policy';
}

class _GsaRoutePrivacyPolicyState extends GsaRouteState<GsaRoutePrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
      body: const GsaWidgetWebContent('https://example.org'),
    );
  }
}
