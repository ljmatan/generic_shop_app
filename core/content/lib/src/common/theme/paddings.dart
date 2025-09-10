part of 'theme.dart';

/// Extension definitions for default application padding values.
///
extension GsaThemePaddings on GsaThemeWrapper {
  /// Default element padding values.
  ///
  ({
    ({
      double miniscule,
      double tiny,
      double extraSmall,
      double small,
      double regular,
      double medium,
      double mediumLarge,
      double large,
      double extraLarge,
      double huge,
    }) content,
    ({
      double cardHorizontal,
      double cardVertical,
      EdgeInsets card,
      double listViewHorizontal,
      double listViewVertical,
      EdgeInsets listView,
    }) widget,
  }) get paddings {
    return (
      content: (
        miniscule: _ContentPaddings.miniscule.value * elementScale,
        tiny: _ContentPaddings.tiny.value * elementScale,
        extraSmall: _ContentPaddings.extraSmall.value * elementScale,
        small: _ContentPaddings.small.value * elementScale,
        regular: _ContentPaddings.regular.value * elementScale,
        medium: _ContentPaddings.medium.value * elementScale,
        mediumLarge: _ContentPaddings.mediumLarge.value * elementScale,
        large: _ContentPaddings.large.value * elementScale,
        extraLarge: _ContentPaddings.extraLarge.value * elementScale,
        huge: _ContentPaddings.huge.value * elementScale,
      ),
      widget: (
        cardHorizontal:
            (dimensions.smallScreen ? _WidgetPaddings.cardHorizontalSmall.value : _WidgetPaddings.cardHorizontalLarge.value) * elementScale,
        cardVertical:
            (dimensions.smallScreen ? _WidgetPaddings.cardVerticalSmall.value : _WidgetPaddings.cardVerticalLarge.value) * elementScale,
        card: EdgeInsets.symmetric(
          horizontal: (dimensions.smallScreen ? _WidgetPaddings.cardHorizontalSmall.value : _WidgetPaddings.cardHorizontalLarge.value) *
              elementScale,
          vertical:
              (dimensions.smallScreen ? _WidgetPaddings.cardVerticalSmall.value : _WidgetPaddings.cardVerticalLarge.value) * elementScale,
        ),
        listViewHorizontal:
            (dimensions.smallScreen ? _WidgetPaddings.listViewHorizontalSmall.value : _WidgetPaddings.listViewHorizontalLarge.value) *
                elementScale,
        listViewVertical:
            (dimensions.smallScreen ? _WidgetPaddings.listViewVerticalSmall.value : _WidgetPaddings.listViewVerticalLarge.value) *
                elementScale,
        listView: EdgeInsets.symmetric(
          horizontal:
              (dimensions.smallScreen ? _WidgetPaddings.listViewHorizontalSmall.value : _WidgetPaddings.listViewHorizontalLarge.value) *
                  elementScale,
          vertical: (dimensions.smallScreen ? _WidgetPaddings.listViewVerticalSmall.value : _WidgetPaddings.listViewVerticalLarge.value) *
              elementScale,
        ),
      ),
    );
  }
}

enum _ContentPaddings {
  miniscule,
  tiny,
  extraSmall,
  small,
  regular,
  medium,
  mediumLarge,
  large,
  extraLarge,
  huge;

  double get value {
    switch (this) {
      case _ContentPaddings.miniscule:
        return 4;
      case _ContentPaddings.tiny:
        return 6;
      case _ContentPaddings.extraSmall:
        return 8;
      case _ContentPaddings.small:
        return 10;
      case _ContentPaddings.regular:
        return 12;
      case _ContentPaddings.medium:
        return 16;
      case _ContentPaddings.mediumLarge:
        return 20;
      case _ContentPaddings.large:
        return 24;
      case _ContentPaddings.extraLarge:
        return 32;
      case _ContentPaddings.huge:
        return 48;
    }
  }
}

enum _WidgetPaddings {
  cardHorizontalSmall,
  cardHorizontalLarge,
  cardVerticalSmall,
  cardVerticalLarge,
  listViewHorizontalSmall,
  listViewHorizontalLarge,
  listViewVerticalSmall,
  listViewVerticalLarge;

  double get value {
    switch (this) {
      case _WidgetPaddings.cardHorizontalSmall:
        return 16;
      case _WidgetPaddings.cardHorizontalLarge:
        return 20;
      case _WidgetPaddings.cardVerticalSmall:
        return 12;
      case _WidgetPaddings.cardVerticalLarge:
        return 16;
      case _WidgetPaddings.listViewHorizontalSmall:
        return 20;
      case _WidgetPaddings.listViewHorizontalLarge:
        return 26;
      case _WidgetPaddings.listViewVerticalSmall:
        return 24;
      case _WidgetPaddings.listViewVerticalLarge:
        return 30;
    }
  }
}
