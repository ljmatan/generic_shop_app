import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Route displaying user help and support information.
///
class GsaRouteHelp extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteHelp({super.key});

  @override
  State<GsaRouteHelp> createState() => _GsaRouteHelpState();
}

class _GsaRouteHelpState extends GsaRouteState<GsaRouteHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.displayName,
        ),
      ),
      body: const GsaWidgetWebContent(
        'https://example.org',
      ),
    );
  }
}
