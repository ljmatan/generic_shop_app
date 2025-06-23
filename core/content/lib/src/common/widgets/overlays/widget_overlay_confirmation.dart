import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// An overlay widget presented to user to confirm an interaction.
///
class GsaWidgetOverlayConfirmation extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlayConfirmation(
    this.message, {
    super.key,
  });

  /// User-facing message clarifying the confirmation request.
  ///
  final String? message;

  @override
  State<GsaWidgetOverlayConfirmation> createState() => _GsaWidgetOverlayConfirmationState();
}

class _GsaWidgetOverlayConfirmationState extends State<GsaWidgetOverlayConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GsaWidgetText(
          widget.message ?? 'Confirm?',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const GsaWidgetText('NO'),
              onPressed: () => Navigator.pop(context, false),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              child: const GsaWidgetText('YES'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      ],
    );
  }
}
