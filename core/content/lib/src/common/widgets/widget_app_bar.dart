import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/src/common/widgets/flair/blobs/widget_blobs.dart';

/// Application toolbar / navigation bar / app bar implementation.
///
class GsaWidgetAppBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Stack(
          children: [
            const GsaWidgetFlairBlobBackground(count: 12),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: child ??
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: showBackButton && Navigator.of(context).canPop() == true
                                ? const EdgeInsets.symmetric(
                                    horizontal: 56,
                                    vertical: 14,
                                  )
                                : const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                            child: Text(
                              label ?? '',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                                shadows: [
                                  for (final offset in <Offset>{
                                    const Offset(-.1, -.1),
                                    const Offset(.1, -.1),
                                    const Offset(.1, .1),
                                    const Offset(-.1, .1),
                                  })
                                    Shadow(
                                      offset: offset,
                                      color: Colors.black,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (showBackButton && Navigator.of(context).canPop() == true)
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.chevron_left,
                                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                              ),
                              onPressed: () => onBackPressed == null ? Navigator.pop(context) : onBackPressed!(),
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
