import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaWidgetStickyBottomButton extends StatelessWidget {
  const GsaWidgetStickyBottomButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withValues(alpha: .05),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).padding.bottom,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GsaWidgetButton.filled(
            label: label,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
