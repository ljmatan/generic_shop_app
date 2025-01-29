import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_web_content.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying the application terms and conditions content and consent mechanisms.
///
class GsaRouteTermsAndConditions extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteTermsAndConditions({super.key});

  @override
  State<GsaRouteTermsAndConditions> createState() => _GsaRouteTermsAndConditionsState();

  @override
  String get routeId => 'terms-and-conditions';

  @override
  String get displayName => 'Terms and Conditions';
}

class _GsaRouteTermsAndConditionsState extends GsarRouteState<GsaRouteTermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.displayName)), body: const GsaWidgetWebContent('https://example.org'));
  }
}
