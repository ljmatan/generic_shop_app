part of 'theme.dart';

/// Default values specified for the [GsaTheme] object configuration.
///
extension _GsaThemeDefaults on GsaTheme {
  Brightness get _brightness {
    final cachedBrightnessName = GsaServiceCacheEntry.themeBrightness.value;
    if (cachedBrightnessName != null) {
      final cachedBrightness = Brightness.values.firstWhereOrNull(
        (brightness) {
          return brightness.name == cachedBrightnessName;
        },
      );
      if (cachedBrightness != null) {
        return cachedBrightness;
      }
    }
    return dart_ui.PlatformDispatcher.instance.platformBrightness;
  }

  Color get _primaryColor {
    if (brightness == Brightness.light) {
      return const Color(0xffE1BEE7);
    } else {
      return const Color(0xff90A4AE);
    }
  }

  Color get _secondaryColor {
    final hsl = HSLColor.fromColor(primaryColor);
    final random = Random();
    final hueShift = 180 + random.nextInt(20) - 10;
    final newHue = (hsl.hue + hueShift) % 360;
    final baseLightness = hsl.lightness;
    final lightnessJitter = (random.nextDouble() * 0.1) - 0.05;
    final adjustedLightness = brightness == Brightness.dark
        ? (baseLightness * 1.1 + lightnessJitter).clamp(0.2, 0.9)
        : (baseLightness * 0.9 + lightnessJitter).clamp(0.2, 0.9);
    final saturationJitter = (random.nextDouble() * 0.2) - 0.1;
    final adjustedSaturation = (hsl.saturation * 0.8 + saturationJitter).clamp(0.3, 1.0);
    final adjusted = HSLColor.fromAHSL(
      hsl.alpha,
      newHue,
      adjustedSaturation,
      adjustedLightness,
    );
    return adjusted.toColor();
  }

  String get _fontFamily {
    return 'packages/generic_shop_app_content/Quicksand';
  }

  SystemUiOverlayStyle get _systemUiOverlayStyle {
    return brightness == Brightness.light
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarContrastEnforced: false,
          )
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarContrastEnforced: false,
          );
  }

  BorderRadius get _borderRadius {
    return BorderRadius.circular(10);
  }

  InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      isDense: true,
      filled: true,
      fillColor: brightness == Brightness.light ? const Color(0xffF0F3F5) : const Color(0xffb3b3b3),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
      ),
      labelStyle: TextStyle(
        color: brightness == Brightness.light ? null : Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      errorStyle: const TextStyle(
        color: Color(0xffDE1E36),
        fontSize: 10,
      ),
      errorMaxLines: 1000,
      helperStyle: TextStyle(
        color: brightness == Brightness.light ? const Color(0xff63747E) : Colors.white,
        fontSize: 10,
      ),
      hintStyle: TextStyle(
        color: brightness == Brightness.light ? const Color(0xff63747E) : Colors.white,
      ),
    );
  }

  EdgeInsetsGeometry get _inputDecorationThemePadding {
    return inputDecorationTheme.contentPadding ?? EdgeInsets.zero;
  }

  RoundedRectangleBorder get _roundedRectangleBorder {
    return RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(
        color: brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade700,
      ),
    );
  }
}
