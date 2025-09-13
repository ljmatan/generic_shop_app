import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// General-purpose widget for displaying of the error text, providing optional handling mechanism.
///
class GsaWidgetError extends StatefulWidget {
  // ignore: public_member_api_docs
  const GsaWidgetError(
    this.message, {
    super.key,
    this.action,
    this.actionLabel,
  });

  /// Error message displayed to the user.
  ///
  final String message;

  /// An optional method aimed at handling invocation retry attempt.
  ///
  final Function? action;

  /// Custom label applied to the button with dedicated [action] functionality.
  ///
  final String? actionLabel;

  @override
  State<GsaWidgetError> createState() => _GsaWidgetErrorState();
}

class _GsaWidgetErrorState extends State<GsaWidgetError> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: const Padding(
              padding: EdgeInsets.all(30),
              child: Icon(
                Icons.warning,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GsaWidgetText(
            widget.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          if (widget.action != null)
            TextButton(
              child: GsaWidgetText(
                widget.actionLabel ?? 'Retry',
              ),
              onPressed: widget.action == null
                  ? null
                  : () {
                      widget.action!();
                    },
            ),
        ],
      ),
    );
  }
}
