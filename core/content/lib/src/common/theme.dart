import 'dart:math';
import 'dart:ui' as dart_ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_architecture/config.dart';

/// The default theme configuration for the application project.
///
class GsaTheme {
  /// Default, unnamed constructor.
  ///
  /// Can be used for specifying a custom [plugin] definition,
  /// and otherwise, the global [instance] property may be accessed.
  ///
  GsaTheme({
    this.platform,
    this.brightness,
    this.primaryColor,
    this.fontFamily,
  });

  /// The platform that user interaction should adapt to target.
  ///
  TargetPlatform? platform;

  /// Custom-defined theme [Brightness], describes the contrast of a theme or color palette.
  ///
  Brightness? brightness;

  /// Color definition for overriding the set defaults.
  ///
  Color? primaryColor;

  /// Specified display font family.
  ///
  String? fontFamily;

  /// Globally-accessible class instance.
  ///
  static final instance = GsaTheme();

  /// The setting indicating the current brightness mode of the host platform.
  ///
  /// If the platform has no preference, the value defaults to [Brightness.light].
  ///
  Brightness platformBrightness = dart_ui.PlatformDispatcher.instance.platformBrightness;

  /// Border radius value applied to elements such as [Card], [OutlinedButton], etc.
  ///
  final borderRadius = BorderRadius.circular(10);

  /// Used to scale the incoming font size by multiplying it with the given text scale factor.
  ///
  TextScaler textScaler(
    BuildContext context, [
    double? screenWidth,
  ]) {
    screenWidth ??= MediaQuery.of(context).size.width;
    return TextScaler.linear(
      screenWidth < 400
          ? 1
          : screenWidth < 600
              ? 1.1
              : screenWidth < 800
                  ? 1.2
                  : screenWidth < 1000
                      ? 1.3
                      : screenWidth < 1400
                          ? 1.4
                          : 1.6,
    );
  }

  Brightness get _brightness {
    return brightness ?? platformBrightness;
  }

  Color get _primaryColor {
    if (primaryColor != null) {
      return primaryColor!;
    }
    if (GsaConfig.plugin.primaryColor != null) {
      return GsaConfig.plugin.primaryColor!;
    }
    if (_brightness == Brightness.light) {
      return const Color(0xffDAB1DA);
    } else {
      return const Color(0xff63183f);
    }
  }

  Color get _secondaryColor {
    final hsl = HSLColor.fromColor(_primaryColor);
    final random = Random();
    final hueShift = 180 + random.nextInt(20) - 10;
    final newHue = (hsl.hue + hueShift) % 360;
    final baseLightness = hsl.lightness;
    final lightnessJitter = (random.nextDouble() * 0.1) - 0.05;
    final adjustedLightness = _brightness == Brightness.dark
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

  String? get _fontFamily {
    return fontFamily ?? GsaConfig.plugin.fontFamily ?? 'packages/generic_shop_app_content/Quicksand';
  }

  InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      isDense: true,
      filled: true,
      fillColor: _brightness == Brightness.light ? const Color(0xffF0F3F5) : const Color(0xffb3b3b3),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
      ),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      errorStyle: const TextStyle(
        color: Color(0xffDE1E36),
        fontSize: 10,
      ),
      errorMaxLines: 1000,
      helperStyle: const TextStyle(
        color: Color(0xff63747E),
        fontSize: 10,
      ),
      hintStyle: const TextStyle(
        color: Color(0xff63747E),
      ),
    );
  }

  RoundedRectangleBorder get _roundedRectangleBorder {
    return RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(
        color: _brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade700,
      ),
    );
  }

  EdgeInsets get contentPadding {
    final size = dart_ui.PlatformDispatcher.instance.implicitView?.physicalSize;
    final ratio = dart_ui.PlatformDispatcher.instance.implicitView?.devicePixelRatio;
    if (size == null || ratio == null) {
      return const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      );
    }
    final screenWidth = size.width / ratio;
    return EdgeInsets.symmetric(
      horizontal: screenWidth < 1000 ? 20 : 30,
      vertical: screenWidth < 1000 ? 24 : 36,
    );
  }

  /// Getter method for the [ThemeData] implementation.
  ///
  ThemeData get data {
    return ThemeData(
      platform: platform,
      primaryColor: _primaryColor,
      fontFamily: _fontFamily,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: _inputDecorationTheme,
        menuStyle: MenuStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme,
      textTheme: _brightness == Brightness.light
          ? TextTheme(
              bodySmall: TextStyle(
                color: Colors.grey.shade600,
              ),
              titleLarge: TextStyle(
                color: _primaryColor,
              ),
              titleMedium: TextStyle(
                color: _primaryColor,
              ),
              titleSmall: TextStyle(
                color: _primaryColor,
              ),
            )
          : TextTheme(
              bodySmall: const TextStyle(
                color: Colors.grey,
              ),
              titleLarge: TextStyle(
                color: _primaryColor,
              ),
              titleMedium: TextStyle(
                color: _primaryColor,
              ),
              titleSmall: TextStyle(
                color: _primaryColor,
              ),
            ),
      dividerColor: _brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade700,
      dividerTheme: const DividerThemeData(
        thickness: .4,
        space: .4,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            _roundedRectangleBorder,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            _roundedRectangleBorder,
          ),
        ),
      ),
      scaffoldBackgroundColor: _brightness == Brightness.light ? Colors.white : const Color(0xff121212),
      colorScheme: _brightness == Brightness.light
          ? ColorScheme(
              brightness: _brightness,
              primary: _primaryColor,
              onPrimary: Colors.white,
              secondary: _secondaryColor,
              onSecondary: Colors.white,
              error: Colors.red.shade300,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.grey.shade300,
              surface: Colors.white,
              onSurface: const Color(0xff121212),
              surfaceTint: Colors.white,
            )
          : ColorScheme(
              brightness: _brightness,
              primary: _primaryColor,
              onPrimary: Colors.grey,
              secondary: _secondaryColor,
              onSecondary: Colors.grey,
              error: Colors.red.shade300,
              onError: Colors.white,
              background: const Color(0xff333333),
              onBackground: Colors.grey.shade400,
              surface: Colors.black,
              onSurface: Colors.white,
              surfaceTint: const Color(0xff212121),
            ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        color: _primaryColor,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      cardTheme: _brightness == Brightness.light
          ? CardThemeData(
              elevation: 0,
              color: Colors.white,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: BorderSide(
                  color: Colors.grey.withValues(alpha: .2),
                ),
              ),
            )
          : CardThemeData(
              elevation: 0,
              color: const Color(0xff212121),
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: BorderSide(
                  color: Colors.grey.withValues(alpha: .2),
                ),
              ),
            ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(_primaryColor),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? _primaryColor.withValues(alpha: .6) : null,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Color.lerp(_primaryColor, Colors.white, .4),
      ),
      tooltipTheme: const TooltipThemeData(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        showDuration: Duration(seconds: 10),
      ),
    );
  }

  /// Specifies a preference for the style of the system overlays.
  ///
  SystemUiOverlayStyle get systemUiOverlayStyle {
    return _brightness == Brightness.light
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
}
