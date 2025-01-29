import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_web_content.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route designed for displaying of the cookie policy and related consent mechanisms.
///
class GsaRouteCookiePolicy extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteCookiePolicy({super.key});

  @override
  State<GsaRouteCookiePolicy> createState() => _GsaRouteCookiePolicyState();

  @override
  String get routeId => 'cookie-policy';

  @override
  String get displayName => 'Cookie Policy';
}

class _GsaRouteCookiePolicyState extends GsarRouteState<GsaRouteCookiePolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.displayName)), body: const GsaWidgetWebContent('https://example.org'));
  }
}
