import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';

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
    if (GsaDataMerchant.instance.merchant?.logoImageUrl != null) {
      return (GsaDataMerchant.instance.merchant!.logoImageUrl!.startsWith(
        'assets',
      )
          ? GsaWidgetImage.asset
          : GsaWidgetImage.network)(
        GsaDataMerchant.instance.merchant!.logoImageUrl!,
        width: width,
        height: height,
      );
    } else if (GsaConfig.mockBuild) {
      return SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: GsaWidgetText.rich(
            [
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
