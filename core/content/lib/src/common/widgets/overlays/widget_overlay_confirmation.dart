import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';
import 'package:generic_shop_app_services/services.dart';

part 'i18n/widget_overlay_confirmation_i18n.dart';

/// An overlay widget presented to user to confirm an interaction.
///
class GsaWidgetOverlayConfirmation extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlayConfirmation(
    this.message, {
    super.key,
    this.additionalContent,
    this.cancelButtonLabel,
    this.confirmButtonLabel,
  });

  /// User-facing message clarifying the confirmation request.
  ///
  final String? message;

  /// Additional content displayed below the [message] view section.
  ///
  final Widget? additionalContent;

  /// User-visible labels applied to the view section of this widget.
  ///
  final String? cancelButtonLabel, confirmButtonLabel;

  @override
  State<GsaWidgetOverlayConfirmation> createState() {
    return _GsaWidgetOverlayConfirmationState();
  }
}

class _GsaWidgetOverlayConfirmationState extends State<GsaWidgetOverlayConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GsaWidgetText(
          widget.message ?? GsaWidgetOverlayConfirmationI18N.message.value.display,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        if (widget.additionalContent != null) ...[
          const SizedBox(height: 20),
          widget.additionalContent!,
        ],
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GsaWidgetButton.text(
              label: widget.cancelButtonLabel ?? GsaWidgetOverlayConfirmationI18N.cancelButtonLabel.value.display,
              onTap: () {
                Navigator.pop(context, false);
              },
            ),
            const SizedBox(width: 8),
            GsaWidgetButton.outlined(
              label: widget.confirmButtonLabel ?? GsaWidgetOverlayConfirmationI18N.confirmButtonLabel.value.display,
              onTap: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ],
    );
  }
}
