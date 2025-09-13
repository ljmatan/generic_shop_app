import 'dart:convert' as dart_convert;

import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

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
    final plugin = GsaPlugin.of(context);
    final logoImagePath = plugin.theme.logoImagePath;
    if (logoImagePath != null) {
      if (logoImagePath.startsWith('BASE64/')) {
        String imageDataEncoded = logoImagePath.replaceAll('BASE64/', '');
        final type = imageDataEncoded.split('/').first;
        imageDataEncoded = imageDataEncoded.replaceAll('$type/', '');
        final imageDataDecoded = dart_convert.base64Decode(imageDataEncoded);
        return GsaWidgetImage.bytes(
          imageDataDecoded,
          type: type == 'svg' ? GsaWidgetImageByteType.svg : GsaWidgetImageByteType.standard,
          width: width,
          height: height,
        );
      }
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
    } else if (plugin.client == GsaPluginClient.demo) {
      return SizedBox(
        width: width,
        height: height,
        child: Center(
          child: GsaWidgetText(
            'Your Logo Here',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              shadows: GsaTheme.of(context).outline.shadows,
            ),
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
