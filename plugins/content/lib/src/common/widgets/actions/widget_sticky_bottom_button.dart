import 'package:flutter/material.dart';

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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: OutlinedButton(
            child: Text(
              label,
            ),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
