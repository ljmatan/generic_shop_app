import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GsaWidgetText(
          widget.displayName,
        ),
      ),
    );
  }
}
