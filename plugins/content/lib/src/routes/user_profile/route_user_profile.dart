import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Route displaying the user profile details.
///
class GsaRouteUserProfile extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteUserProfile({super.key});

  @override
  State<GsaRouteUserProfile> createState() => _GsaRouteUserProfileState();
}

class _GsaRouteUserProfileState extends GsaRouteState<GsaRouteUserProfile> {
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
