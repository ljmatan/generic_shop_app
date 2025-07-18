import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Application toolbar / navigation bar / app bar implementation.
///
class GsaWidgetAppBar extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetAppBar({
    super.key,
    this.label,
    this.child,
    this.showBackButton = true,
    this.onBackPressed,
  });

  /// Title label displayed with this app bar element.
  ///
  final String? label;

  /// A widget implementation used in place of [label].
  ///
  final Widget? child;

  /// Whether to display a "back" navigation button.
  ///
  /// The back button is usually shown if `Navigator.of(context).canPop() == true`.
  ///
  final bool showBackButton;

  /// Custom callback applied to the back button.
  ///
  final Function? onBackPressed;

  @override
  State<GsaWidgetAppBar> createState() => _GsaWidgetAppBarState();
}

class _GsaWidgetAppBarState extends State<GsaWidgetAppBar> {
  /// Whether this widget can invoke the [Navigator.pop] method.
  ///
  bool? _canPop;

  @override
  Widget build(BuildContext context) {
    _canPop ??= Navigator.of(context).canPop();
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Stack(
          children: [
            const GsaWidgetFlairBlobBackground(count: 12),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: widget.child ??
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: widget.showBackButton && (_canPop == true || widget.onBackPressed != null)
                                ? EdgeInsets.symmetric(
                                    horizontal: 56,
                                    vertical: 14 * Theme.of(context).elementScale,
                                  )
                                : EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14 * Theme.of(context).elementScale,
                                  ),
                            child: GsaWidgetText(
                              widget.label ?? '',
                              textAlign: Theme.of(context).dimensions.smallScreen ? TextAlign.center : TextAlign.left,
                              style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                                    shadows: Theme.of(context).outlineShadows,
                                  ),
                            ),
                          ),
                        ),
                        if (widget.showBackButton && (_canPop == true || widget.onBackPressed != null))
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: GsaWidgetButton.icon(
                              icon: Icons.chevron_left,
                              foregroundColor: Theme.of(context).appBarTheme.titleTextStyle?.color,
                              outlined: true,
                              onTap: () => widget.onBackPressed == null
                                  ? _canPop == true
                                      ? Navigator.pop(context)
                                      : null
                                  : widget.onBackPressed!(),
                            ),
                          ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
