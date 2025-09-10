part of 'theme.dart';

/// Wrapper widget implemented for access to property values via widget tree.
///
class GsaThemeWrapper extends StatelessWidget {
  /// A wrapper for theme-related functionality within the application.
  ///
  /// This file is intended to provide utilities or classes that help manage
  /// and apply consistent theming across the app.
  ///
  const GsaThemeWrapper({
    super.key,
    required this.theme,
    required this.screenSize,
    required this.viewScale,
    required this.child,
  });

  /// Relevant theme instance.
  ///
  final GsaTheme theme;

  /// Screen size values in DIP units.
  ///
  final Size screenSize;

  /// The scale of elements specified by with OS accessibility services.
  ///
  final double viewScale;

  /// The child descendant.
  ///
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
    double width,
    List<Shadow> shadows,
  }) get outline {
    return (
      width: dimensions.smallScreen ? .1 : .4,
      shadows: (() {
        final width = dimensions.smallScreen ? .1 : .4;
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
      })(),
    );
  }
}
