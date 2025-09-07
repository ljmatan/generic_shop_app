import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

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
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          const Expanded(
            child: GsaWidgetWebContent(
              'https://example.org',
            ),
          ),
        ],
      ),
    );
  }
}
