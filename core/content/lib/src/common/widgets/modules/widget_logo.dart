import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Logo image, display visible content if an image is provided with the
/// [GsaDataMerchant.instance.merchant.logoImageUrl] property.
///
class GsaWidgetLogo extends StatelessWidget {
  /// Default, unnamed widget constructor.
  ///
  /// Required [width] and [height] properties are applied as the widget dimensions.
  ///
  const GsaWidgetLogo({
    super.key,
    this.width,
    this.height,
  });

  /// Logo graphic display dimensions.
  ///
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    final logoImagePath = GsaConfig.plugin.theme.logoImagePath;
    if (logoImagePath != null) {
      if (logoImagePath.startsWith('assets') || logoImagePath.startsWith('packages')) {
        return GsaWidgetImage.asset(
          logoImagePath,
          width: width,
          height: height,
        );
      } else {
        return GsaWidgetImage.network(
          logoImagePath,
          width: width,
          height: height,
        );
      }
    }
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
