import 'dart:math';
import 'dart:ui' as dart_ui;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

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

  /// Private constructor defined for [instance] property initialisation.
  ///
  /// The constructor fetches and applies cached theme data and applies.
  ///
  GsaTheme._() {
    final cachedBrightnessName = GsaServiceCacheEntry.themeBrightness.value;
    if (cachedBrightnessName != null) {
      brightness = Brightness.values.firstWhereOrNull(
        (brightness) {
          return brightness.name == cachedBrightnessName;
        },
      );
    }
  }

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
  static final instance = GsaTheme._();

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
      MediaQuery.of(context).textScaler.scale(1) *
          (screenWidth < 400
              ? 1
              : screenWidth < 600
                  ? 1.1
                  : screenWidth < 800
                      ? 1.2
                      : screenWidth < 1000
                          ? 1.3
                          : screenWidth < 1400
                              ? 1.4
                              : 1.6),
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
      labelStyle: TextStyle(
        color: _brightness == Brightness.light ? null : Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      errorStyle: const TextStyle(
        color: Color(0xffDE1E36),
        fontSize: 10,
      ),
      errorMaxLines: 1000,
      helperStyle: TextStyle(
        color: _brightness == Brightness.light ? const Color(0xff63747E) : Colors.white,
        fontSize: 10,
      ),
      hintStyle: TextStyle(
        color: _brightness == Brightness.light ? const Color(0xff63747E) : Colors.white,
      ),
    );
  }

  EdgeInsetsGeometry get _inputDecorationThemePadding {
    return _inputDecorationTheme.contentPadding ?? EdgeInsets.zero;
  }

  RoundedRectangleBorder get _roundedRectangleBorder {
    return RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(
        color: _brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade700,
      ),
    );
  }

  /// Getter method for the [ThemeData] implementation.
  ///
  ThemeData get data {
    return ThemeData(
      platform: platform,
      brightness: _brightness,
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
          padding: WidgetStatePropertyAll(
            _inputDecorationThemePadding,
          ),
          iconColor: WidgetStatePropertyAll(
            _brightness == Brightness.light ? null : Colors.white,
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              color: _brightness == Brightness.light ? null : Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          foregroundColor: WidgetStatePropertyAll(
            _brightness == Brightness.light ? null : Colors.white,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            _roundedRectangleBorder,
          ),
          padding: WidgetStatePropertyAll(
            _inputDecorationThemePadding,
          ),
          iconColor: WidgetStatePropertyAll(
            _brightness == Brightness.light ? null : Colors.white,
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              color: _brightness == Brightness.light ? null : Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          foregroundColor: WidgetStatePropertyAll(
            _brightness == Brightness.light ? null : Colors.white,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            _inputDecorationThemePadding,
          ),
          iconColor: WidgetStatePropertyAll(
            _brightness == Brightness.light ? null : Colors.white,
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              color: _brightness == Brightness.light ? null : Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          foregroundColor: WidgetStatePropertyAll(
            _brightness == Brightness.light ? null : Colors.white,
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
      iconTheme: IconThemeData(
        color: _brightness == Brightness.light ? null : Colors.white,
        applyTextScaling: true,
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
          applyTextScaling: true,
        ),
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: _brightness == Brightness.light ? Colors.white : const Color(0xff212121),
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

/// Extension methods and properties for the [ThemeData] object.
///
extension GsaThemeExt on ThemeData {
  /// Method providing screen specifications.
  ///
  /// [size] -> The current dimensions of the rectangle as last reported by the platform
  /// into which scenes rendered in this view are drawn.
  ///
  /// [ratio] -> The number of device pixels for each logical pixel for the screen this view is displayed on.
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
    final screenSpecs = screenSpecifications;
    if (screenSpecs.size == null || screenSpecs.ratio == null) {
      return null;
    }
    return Size(screenSpecs.size!.width / screenSpecs.ratio!, screenSpecs.size!.height / screenSpecs.ratio!);
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

  /// Default padding specified for [ListView] and other such elements.
  ///
  EdgeInsets get listViewPadding {
    return EdgeInsets.symmetric(
      horizontal: dimensions.smallScreen ? 20 : 26,
      vertical: dimensions.smallScreen ? 24 : 30,
    );
  }

  /// Default padding specified for [Card] elements.
  ///
  EdgeInsets get cardPadding {
    return EdgeInsets.symmetric(
      horizontal: dimensions.smallScreen ? 16 : 20,
      vertical: dimensions.smallScreen ? 12 : 16,
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
}
