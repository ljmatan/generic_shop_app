import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Widget overlay serving for user input blocking.
///
class GsaWidgetOverlayContentBlocking extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlayContentBlocking({
    super.key,
  });

  @override
  bool get customBuilder => true;

  @override
  bool get useSafeArea => false;

  @override
  bool get barrierDismissible => false;

  @override
  State<GsaWidgetOverlayContentBlocking> createState() => _GsaWidgetOverlayContentBlockingState();
}

class _GsaWidgetOverlayContentBlockingState extends State<GsaWidgetOverlayContentBlocking> {
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white70,
        ),
        child: SizedBox.expand(),
      ),
    );
  }
}
