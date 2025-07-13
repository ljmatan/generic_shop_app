import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// General-purpose widget for displaying of the error text, providing optional handling mechanism.
///
class GsaWidgetError extends StatefulWidget {
  // ignore: public_member_api_docs
  const GsaWidgetError(
    this.message, {
    super.key,
    this.retry,
    this.retryLabel,
  });

  /// Error message displayed to the user.
  ///
  final String message;

  /// An optional method aimed at handling invocation retry attempt.
  ///
  final Function? retry;

  /// Custom label applied to the button with dedicated [retry] functionality.
  ///
  final String? retryLabel;

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
          if (widget.retry != null)
            OutlinedButton(
              child: GsaWidgetText(widget.retryLabel ?? 'Retry'),
              onPressed: () => widget.retry!(),
            ),
        ],
      ),
    );
  }
}
