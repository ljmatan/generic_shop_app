part of 'theme.dart';

class GsaThemeWrapper extends StatelessWidget {
  GsaThemeWrapper({
    required this.theme,
    required this.screenSize,
    required this.viewScale,
    required this.child,
  });

  final GsaTheme theme;

  final Size screenSize;

  final double viewScale;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }

  /// Used to scale the incoming font size by multiplying it with the given text scale factor.
  ///
  TextScaler get textScaler {
    return theme.textScaler(
      screenSpecs: (
        scale: viewScale,
        width: screenSize.width,
      ),
    );
  }

  /// Scale at which the regular elements are being sized.
  ///
  double get elementScale {
    return textScaler.scale(1);
  }

  /// Getter method defining available screen dimensions.
  ///
  ({
    bool smallScreen,
    bool largeScreen,
  }) get dimensions {
    return (
      smallScreen: screenSize.width < 1000,
      largeScreen: screenSize.width >= 1000,
    );
  }

  /// Default font size applied to [Text] widgets.
  ///
  double get defaultTextSize {
    return theme.data.textTheme.bodyMedium?.fontSize ?? kDefaultFontSize;
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
    return dimensions.smallScreen ? screenSize.width : 800;
  }

  /// Method used for calculating approximate [Text] widget size.
  ///
  Size measureTextSize({
    required String text,
    required TextStyle style,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
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
