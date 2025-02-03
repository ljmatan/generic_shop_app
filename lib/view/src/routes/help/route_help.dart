import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_web_content.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying user help and support information.
///
class GsaRouteHelp extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteHelp({super.key});

  @override
  State<GsaRouteHelp> createState() => _GsaRouteHelpState();
}

class _GsaRouteHelpState extends GsarRouteState<GsaRouteHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.displayName)), body: const GsaWidgetWebContent('https://example.org'));
  }
}
