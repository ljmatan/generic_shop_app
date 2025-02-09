import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_ivancica/view/src/routes/routes.dart';

/// Screen containing user profile information and configuration options.
///
class GivRouteUserProfile extends GivRoute {
  /// Default, unnamed widget constructor.
  ///
  const GivRouteUserProfile({
    super.key,
  });

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
      body: GsaDataUser.instance.user == null
          ? GsaWidgetError(
              'No user information found.',
            )
          : ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              children: [
                if (GsaDataUser.instance.user!.personalDetails?.formattedName != null)
                  Text(
                    GsaDataUser.instance.user!.personalDetails!.formattedName!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
              ],
            ),
    );
  }
}
