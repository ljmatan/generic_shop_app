import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Route for display of the 3rd-party software licence and attribution information.
///
class GsaRouteLicences extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteLicences({super.key});

  @override
  State<GsaRouteLicences> createState() => _GsaRouteLicencesState();
}

class _GsaRouteLicencesState extends GsaRouteState<GsaRouteLicences> {
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
        ],
      ),
    );
  }
}
