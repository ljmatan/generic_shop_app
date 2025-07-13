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
    required this.width,
    required this.height,
  });

  /// Logo graphic display dimensions.
  ///
  final double width, height;

  @override
  Widget build(BuildContext context) {
    final logoImagePath = GsaConfig.plugin.logoImagePath;
    if (logoImagePath != null) {
      return (logoImagePath.startsWith('assets') || logoImagePath.startsWith('packages') ? GsaWidgetImage.asset : GsaWidgetImage.network)(
        logoImagePath,
        width: width,
        height: height,
      );
    } else if (GsaConfig.mockBuild) {
      return SizedBox(
        width: width,
        height: height,
        child: Center(
          child: GsaWidgetText.rich(
            const [
              GsaWidgetTextSpan(
                'Example ',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                ),
              ),
              GsaWidgetTextSpan(
                'LOGO',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
