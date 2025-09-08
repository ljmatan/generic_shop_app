part of 'theme.dart';

/// Extension methods and properties for the [ThemeData] object.
///
extension GsaThemeDataExt on ThemeData {
  /// Method providing screen specifications.
  ///
  /// [size] -> The current dimensions of the rectangle as last reported by the platform
  /// into which scenes rendered in this view are drawn.
  ///
  /// [ratio] -> The number of device pixels for each logical pixel for the screen
  /// this view is displayed on.
  ///
  ({
    Size? size,
    double? ratio,
  }) get screenSpecifications {
    final size = dart_ui.PlatformDispatcher.instance.implicitView?.physicalSize;
    final ratio = dart_ui.PlatformDispatcher.instance.implicitView?.devicePixelRatio;
    return (
      size: size,
      ratio: ratio,
    );
  }

  /// Returns the screen dimension specification in DIP format.
  ///
  /// Returns `null` if the data cannot be retrieved.
  ///
  Size? get screenSize {
    try {
      final navigatorKey = GsaRoute.navigatorKey;
      if (navigatorKey.currentContext == null) {
        throw Exception('No context available');
      }
      return MediaQuery.of(navigatorKey.currentContext!).size;
    } catch (e) {
      final screenSpecs = screenSpecifications;
      if (screenSpecs.size == null || screenSpecs.ratio == null) {
        return null;
      }
      return Size(screenSpecs.size!.width / screenSpecs.ratio!, screenSpecs.size!.height / screenSpecs.ratio!);
    }
  }

  /// Scale at which the regular elements are being sized.
  ///
  double get elementScale {
    if (GsaRoute.navigatorContext == null) return 1;
    return MediaQuery.of(GsaRoute.navigatorKey.currentContext!).textScaler.scale(1);
  }

  /// Getter method defining available screen dimensions.
  ///
  ({
    bool smallScreen,
    bool largeScreen,
  }) get dimensions {
    final size = screenSize;
    if (size == null) {
      return (
        smallScreen: true,
        largeScreen: false,
      );
    }
    return (
      smallScreen: size.width < 1000,
      largeScreen: size.width >= 1000,
    );
  }

  /// Default font size applied to [Text] widgets.
  ///
  double get defaultTextSize {
    return textTheme.bodyMedium?.fontSize ?? kDefaultFontSize;
  }

  /// Default height of "action-type" elements (e.g., buttons).
  ///
  double get actionElementHeight {
    final textSize = defaultTextSize;
    return (kMinInteractiveDimension - textSize) + textSize * elementScale;
  }

  /// Default element padding values.
  ///
  ({
    double Function() cardHorizontal,
    double Function() cardVertical,
    EdgeInsets Function() card,
    double Function() listViewHorizontal,
    double Function() listViewVertical,
    EdgeInsets Function() listView,
  }) get paddings {
    return (
      cardHorizontal: () {
        return dimensions.smallScreen ? 16 : 20;
      },
      cardVertical: () {
        return dimensions.smallScreen ? 12 : 16;
      },
      card: () {
        return EdgeInsets.symmetric(
          horizontal: paddings.cardHorizontal(),
          vertical: paddings.cardVertical(),
        );
      },
      listViewHorizontal: () {
        return dimensions.smallScreen ? 20 : 26;
      },
      listViewVertical: () {
        return dimensions.smallScreen ? 24 : 30;
      },
      listView: () {
        return EdgeInsets.symmetric(
          horizontal: paddings.listViewHorizontal(),
          vertical: paddings.listViewVertical(),
        );
      },
    );
  }

  /// Maximum specified width for overlay and inline elements.
  ///
  double get maxOverlayInlineWidth {
    return dimensions.smallScreen ? (screenSize?.width ?? double.infinity) : 800;
  }

  /// Method used for calculating approximate [Text] widget size.
  ///
  Size measureTextSize({
    required String text,
    required TextStyle style,
  }) {
    if (GsaRoute.navigatorKey.currentContext == null) {
      return const Size(0, 0);
    }
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.of(
        GsaRoute.navigatorKey.currentContext!,
      ).textScaler,
    )..layout();
    return textPainter.size;
  }

  /// Specifications for element (e.g., [Text] or [Icon] widget) outline.
  ///
  ({
    double Function() width,
    List<Shadow> Function() shadows,
  }) get outline {
    return (
      width: () {
        return dimensions.smallScreen ? .1 : .4;
      },
      shadows: () {
        final width = outline.width();
        return [
          for (final offset in <Offset>{
            Offset(-width, -width),
            Offset(width, -width),
            Offset(width, width),
            Offset(-width, width),
          })
            Shadow(
              offset: offset,
              color: Colors.black,
            ),
        ];
      },
    );
  }
}
