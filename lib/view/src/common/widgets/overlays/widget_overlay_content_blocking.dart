import 'package:flutter/material.dart';
import 'package:generic_shop_app/services/services.dart';

/// Widget overlay serving for user input blocking.
///
class GsaWidgetOverlayContentBlocking extends StatefulWidget {
  const GsaWidgetOverlayContentBlocking._();

  /// Displays the blocking dialog widget to the user using the Flutter SDK [showDialog] method.
  ///
  /// The [context] property can optionally be provided, otherwise the top-most BuildContext object is used.
  ///
  static Future<void> open([BuildContext? context]) async {
    return await showDialog(
      context: context ?? GsaServiceNavigator.instance.context,
      barrierDismissible: false,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const GsaWidgetOverlayContentBlocking._();
      },
    );
  }

  @override
  State<GsaWidgetOverlayContentBlocking> createState() => _GsaWidgetOverlayContentBlockingState();
}

class _GsaWidgetOverlayContentBlockingState extends State<GsaWidgetOverlayContentBlocking> {
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white70),
        child: SizedBox.expand(),
      ),
    );
  }
}
