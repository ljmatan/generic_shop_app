import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// An overlay widget presented to user with a message.
///
class GsaWidgetOverlayAlert extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlayAlert(
    this.message, {
    super.key,
    this.title,
  });

  /// User-facing alert message.
  ///
  final String message;

  /// The title for the dialog.
  ///
  final String? title;

  @override
  State<GsaWidgetOverlayAlert> createState() => _GsaWidgetOverlayAlertState();
}

class _GsaWidgetOverlayAlertState extends State<GsaWidgetOverlayAlert> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          GsaWidgetText(
            widget.title!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
        ],
        GsaWidgetText(
          widget.message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: GsaWidgetButton.outlined(
            label: 'OK',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
