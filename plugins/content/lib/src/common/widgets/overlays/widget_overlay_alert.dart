import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_content/src/common/widgets/overlays/widget_overlay.dart';

/// An overlay widget presented to user with a message.
///
class GsaWidgetOverlayAlert extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlayAlert({
    super.key,
    this.title,
    required this.message,
  });

  /// The title for the dialog.
  ///
  final String? title;

  /// User-facing alert message.
  ///
  final String message;

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
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      child: const GsaWidgetText('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
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
