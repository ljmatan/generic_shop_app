import 'dart:math' as dart_math;

import 'package:flutter/material.dart';

part 'elements/element_animated_blob.dart';
part 'elements/element_blob_background.dart';
part 'models/model_blob_point.dart';
part 'painters/painter_blob.dart';

/// Decorative background widget, displaying animated "blob" shapes.
///
class GsaWidgetFlairBlobBackground extends StatelessWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetFlairBlobBackground({
    super.key,
    this.color,
    this.count = 12,
    this.centerOverlay = false,
  });

  /// Color from which the blob background styling is derived.
  ///
  /// Defaults to `Theme.of(context).primaryColor`.
  ///
  final Color? color;

  /// The number of blobs rendered on screen.
  ///
  final int count;

  /// Defines whether a white blob overlay is placed in the center of display.
  ///
  /// Useful for displaying of additional information.
  ///
  final bool centerOverlay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _ElementBlobBackground(
          color: color,
          count: count,
          centerOverlay: centerOverlay,
        ),
        if (centerOverlay)
          _ElementAnimatedBlob(
            color: Colors.white,
            pointCount: 50,
            baseRadius: (MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.height) /
                    2 +
                40,
            duration: const Duration(seconds: 10),
          ),
      ],
    );
  }
}
