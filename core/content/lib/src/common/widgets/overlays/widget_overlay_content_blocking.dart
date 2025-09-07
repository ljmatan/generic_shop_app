import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Widget overlay serving for user input blocking.
///
class GsaWidgetOverlayContentBlocking extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlayContentBlocking({
    super.key,
    this.displayLoadingIndicator = true,
  });

  /// Whether to display a loading indicator at the center of the widget contents.
  ///
  final bool displayLoadingIndicator;

  @override
  bool get customBuilder => true;

  @override
  bool get useSafeArea => false;

  @override
  bool get barrierDismissible => false;

  @override
  State<GsaWidgetOverlayContentBlocking> createState() {
    return _GsaWidgetOverlayContentBlockingState();
  }
}

class _GsaWidgetOverlayContentBlockingState extends State<GsaWidgetOverlayContentBlocking> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white70,
        ),
        child: SizedBox.expand(
          child: widget.displayLoadingIndicator
              ? const Center(
                  child: GsaWidgetLoadingIndicator(),
                )
              : null,
        ),
      ),
    );
  }
}
