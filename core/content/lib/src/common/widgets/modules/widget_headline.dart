import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

class GsaWidgetHeadline extends StatelessWidget {
  const GsaWidgetHeadline(
    this.message, {
    super.key,
    this.action,
    this.textColor,
    this.fontSize,
  });

  final String message;

  final ({
    String label,
    VoidCallback onTap,
  })? action;

  final Color? textColor;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: GsaWidgetText(
                message,
                style: TextStyle(
                  color: textColor ?? Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize ?? 16,
                ),
              ),
            ),
            if (action != null)
              GsaWidgetButton.text(
                label: action!.label,
                onTap: action!.onTap,
              ),
          ],
        ),
        if (action == null) const SizedBox(height: 10),
        const Divider(height: 0),
        const SizedBox(height: 10),
      ],
    );
  }
}
