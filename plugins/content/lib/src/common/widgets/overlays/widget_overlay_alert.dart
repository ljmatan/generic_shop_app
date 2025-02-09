import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// An overlay widget presented to user with a message.
///
class GsaWidgetOverlayAlert extends StatefulWidget {
  const GsaWidgetOverlayAlert._(this.message);

  /// User-facing alert message.
  ///
  final String? message;

  /// Displays the [GsaWidgetOverlayAlert] widget as an overlay.
  ///
  static Future<void> open(BuildContext context, String? message) async {
    await showDialog(
      context: context,
      builder: (context) {
        return GsaWidgetOverlayAlert._(message);
      },
    );
  }

  @override
  State<GsaWidgetOverlayAlert> createState() => _GsaWidgetOverlayAlertState();
}

class _GsaWidgetOverlayAlertState extends State<GsaWidgetOverlayAlert> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: GestureDetector(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(26, 0, 26, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 26),
                  GsaWidgetText(
                    widget.message ?? 'An error has occurred.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    child: const GsaWidgetText('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {},
        ),
      ),
      onTap: () => Navigator.pop(context, false),
    );
  }
}
