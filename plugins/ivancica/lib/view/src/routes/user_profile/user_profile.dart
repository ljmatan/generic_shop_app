import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_ivancica/view/src/routes/routes.dart';

/// Screen containing user profile information and configuration options.
///
class GivRouteUserProfile extends GivRoute {
  /// Default, unnamed widget constructor.
  ///
  const GivRouteUserProfile(
    this.userDetails, {
    super.key,
  });

  /// Specified user details for this route display.
  ///
  final GsaModelUser userDetails;

  @override
  State<GivRouteUserProfile> createState() => _GivRouteUserProfileState();
}

class _GivRouteUserProfileState extends GsaRouteState<GivRouteUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.displayName,
        ),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
