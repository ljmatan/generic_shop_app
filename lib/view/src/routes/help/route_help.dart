import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_web_content.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';

/// Route displaying user help and support information.
///
class GsaRouteHelp extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteHelp({super.key});

  @override
  State<GsaRouteHelp> createState() => _GsaRouteHelpState();

  @override
  String get routeId => 'help';

  @override
  String get displayName => 'Help and Support';
}

class _GsaRouteHelpState extends GsaRouteState<GsaRouteHelp> {
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
