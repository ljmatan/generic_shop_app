import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying the user profile details.
///
class GsaRouteUserProfile extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteUserProfile({super.key});

  @override
  State<GsaRouteUserProfile> createState() => _GsaRouteUserProfileState();
}

class _GsaRouteUserProfileState extends GsarRouteState<GsaRouteUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.displayName,
        ),
      ),
    );
  }
}
