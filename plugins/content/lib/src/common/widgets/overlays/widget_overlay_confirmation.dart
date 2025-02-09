import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// An overlay widget presented to user to confirm an interaction.
///
class GsaWidgetOverlayConfirmation extends StatefulWidget {
  const GsaWidgetOverlayConfirmation._(this.message);

  /// User-facing message clarifying the confirmation request.
  ///
  final String? message;

  /// Displays the [GsaWidgetOverlayConfirmation] widget,
  /// returning true on exit if the user had confirmed the available selection.
  ///
  static Future<bool> open(BuildContext context, String? message) async {
    return await showDialog(
          context: context,
          builder: (context) {
            return GsaWidgetOverlayConfirmation._(message);
          },
        ) ==
        true;
  }

  @override
  State<GsaWidgetOverlayConfirmation> createState() => _GsaWidgetOverlayConfirmationState();
}

class _GsaWidgetOverlayConfirmationState extends State<GsaWidgetOverlayConfirmation> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
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
                      widget.message ?? 'Confirm?',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
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
                ),
              ),
            ),
            onTap: () {},
          ),
        ),
      ),
      onTap: () => Navigator.pop(context, false),
    );
  }
}
