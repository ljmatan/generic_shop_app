import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Base class for implementation of overlaying (e.g., dialog) widgets.
///
abstract class GsaWidgetOverlay extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlay({super.key});

  /// Specifies whether the sheet will avoid system intrusions on the screen sides.
  ///
  bool get useSafeArea => true;

  /// This property is used to specify the color of the modal barrier.
  ///
  Color get barrierColor => Colors.transparent;

  /// Defines whether this overlay is dismissible by the user.
  ///
  bool get barrierDismissible => true;

  /// Displays the overlay widget contents by utilising any given [BuildContext] object.
  ///
  Future<dynamic> openDialog(BuildContext? context) async {
    context ??= GsaRoute.navigatorKey.currentContext;
    if (context != null) {
      return await showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        useSafeArea: useSafeArea,
        builder: (context) {
          return this;
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
  Future<dynamic> openBottomSheet(BuildContext? context) async {
    context ??= GsaRoute.navigatorKey.currentContext;
    if (context != null) {
      return await showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        showDragHandle: showDragHandle,
        barrierColor: barrierColor,
        useSafeArea: useSafeArea,
        builder: (context) {
          return this;
        },
      );
    }
  }
}
