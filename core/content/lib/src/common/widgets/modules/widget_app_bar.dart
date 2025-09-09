import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

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
    try {
      _canPop ??= Navigator.of(context).canPop();
    } catch (e) {
      _canPop = false;
    }
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Stack(
          children: [
            if (GsaPlugin.of(context).theme.animatedAppBar != false)
              const GsaWidgetFlairBlobBackground(count: 12)
            else
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: SizedBox.expand(),
              ),
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
                                    vertical: 14 * GsaTheme.of(context).elementScale,
                                  )
                                : EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14 * GsaTheme.of(context).elementScale,
                                  ),
                            child: GsaWidgetText(
                              widget.label ?? '',
                              textAlign: GsaTheme.of(context).dimensions.smallScreen ? TextAlign.center : TextAlign.left,
                              style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                                    shadows:
                                        GsaPlugin.of(context).theme.animatedAppBar != false ? GsaTheme.of(context).outline.shadows() : null,
                                  ),
                            ),
                          ),
                        ),
                        if (GsaTheme.of(context).dimensions.largeScreen && GsaPlugin.of(context).theme.logoImagePath != null)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 16,
                            child: GsaWidgetLogo(
                              width: 200,
                              height: MediaQuery.of(context).size.height,
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
                              outlined: GsaPlugin.of(context).theme.animatedAppBar,
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
