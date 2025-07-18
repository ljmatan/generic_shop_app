import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

export 'widget_overlay_alert.dart';
export 'widget_overlay_confirmation.dart';
export 'widget_overlay_content_blocking.dart';
export 'widget_overlay_legal_consent.dart';
export 'widget_overlay_sale_item.dart';

/// Base class for implementation of overlaying (e.g., dialog) widgets.
///
class GsaWidgetOverlay extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlay({
    super.key,
    this.child = const SizedBox(),
  });

  /// Child widget specified for display within an overlaying view.
  ///
  final Widget child;

  /// Whether a custom (non-standard) builder function is specified for this widget.
  ///
  bool get customBuilder => false;

  /// Specifies whether the sheet will avoid system intrusions on the screen sides.
  ///
  bool get useSafeArea => true;

  /// This property is used to specify the color of the modal barrier.
  ///
  Color get barrierColor {
    if (GsaTheme.instance.data.brightness == Brightness.light) {
      return Colors.white70;
    } else {
      return Colors.black26;
    }
  }

  /// Defines whether this overlay is dismissible by the user.
  ///
  bool get barrierDismissible => true;

  /// Displays the overlay widget contents by utilising any given [BuildContext] object.
  ///
  Future<dynamic> openDialog([BuildContext? context]) async {
    context ??= GsaRoute.navigatorKey.currentContext;
    if (context != null) {
      return await showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        useSafeArea: useSafeArea,
        useRootNavigator: false,
        builder: (context) {
          return customBuilder
              ? this
              : Center(
                  child: Card(
                    margin: Theme.of(context).dimensions.smallScreen
                        ? const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 26,
                          )
                        : EdgeInsets.zero,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Theme.of(context).maxOverlayInlineWidth,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(18, 26, 18, 16),
                        child: this,
                      ),
                    ),
                  ),
                );
        },
      );
    }
  }

  /// Specifies whether this is a route for a bottom sheet that will utilize [DraggableScrollableSheet].
  ///
  bool get isScrollControlled => false;

  /// Specifies whether a drag handle is shown. The drag handle appears at the top of the bottom sheet.
  ///
  bool get showDragHandle => false;

  /// Shows a modal Material Design bottom sheet.
  ///
  Future<dynamic> openBottomSheet([BuildContext? context]) async {
    context ??= GsaRoute.navigatorKey.currentContext;
    if (context != null) {
      return await showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        showDragHandle: showDragHandle,
        barrierColor: barrierColor,
        useSafeArea: useSafeArea,
        useRootNavigator: false,
        builder: (context) {
          return customBuilder ? this : this;
        },
      );
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _GsaWidgetOverlayState();
  }
}

class _GsaWidgetOverlayState extends State<GsaWidgetOverlay> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
