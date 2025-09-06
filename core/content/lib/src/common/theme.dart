import 'dart:math';
import 'dart:ui' as dart_ui;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

/// The default theme configuration for the application project.
///
class GsaTheme {
  /// Private constructor defined for [instance] property initialisation.
  ///
  /// The constructor fetches and applies cached theme data and applies.
  ///
  GsaTheme._() {
    final cachedBrightnessName = GsaServiceCacheEntry.themeBrightness.value;
    if (cachedBrightnessName != null) {
      final cachedBrightness = Brightness.values.firstWhereOrNull(
        (brightness) {
          return brightness.name == cachedBrightnessName;
        },
      );
      if (cachedBrightness != null) {
        brightness = cachedBrightness;
      }
    }
  }

  /// Globally-accessible class instance.
  ///
  static final instance = GsaTheme._();

  /// The platform that user interaction should adapt to target.
  ///
  TargetPlatform? platform;

  /// The setting indicating the current brightness mode of the host platform.
  ///
  /// If the platform has no preference, the value defaults to [Brightness.light].
  ///
  Brightness brightness = dart_ui.PlatformDispatcher.instance.platformBrightness;

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

  Color get _primaryColor {
    if (GsaConfig.plugin.theme.primaryColor != null) {
      return GsaConfig.plugin.theme.primaryColor!;
    }
    if (brightness == Brightness.light) {
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

  String? get fontFamily {
    return GsaConfig.plugin.theme.fontFamily ?? 'packages/generic_shop_app_content/Quicksand';
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
    return _inputDecorationTheme.contentPadding ?? EdgeInsets.zero;
  }

  RoundedRectangleBorder get _roundedRectangleBorder {
    return RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(
        color: brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade700,
      ),
    );
  }

  /// Getter method for the [ThemeData] implementation.
  ///
  ThemeData get data {
    return ThemeData(
      platform: platform,
      brightness: brightness,
      primaryColor: _primaryColor,
      fontFamily: fontFamily,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
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
      textTheme: brightness == Brightness.light
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
      dividerColor: brightness == Brightness.light ? Colors.grey.shade200 : Colors.grey.shade700,
      dividerTheme: const DividerThemeData(
        thickness: .4,
        space: .4,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        expandedAlignment: Alignment.centerLeft,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(
            Colors.transparent,
          ),
          shape: WidgetStatePropertyAll(
            _roundedRectangleBorder,
          ),
          padding: WidgetStatePropertyAll(
            _inputDecorationThemePadding,
          ),
          iconColor: WidgetStatePropertyAll(
            brightness == Brightness.light ? null : Colors.white,
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              color: brightness == Brightness.light ? null : Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          foregroundColor: WidgetStatePropertyAll(
            brightness == Brightness.light ? null : Colors.white,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(
            Colors.transparent,
          ),
          shape: WidgetStatePropertyAll(
            _roundedRectangleBorder,
          ),
          padding: WidgetStatePropertyAll(
            _inputDecorationThemePadding,
          ),
          iconColor: WidgetStatePropertyAll(
            brightness == Brightness.light ? null : Colors.white,
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              color: brightness == Brightness.light ? null : Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          foregroundColor: WidgetStatePropertyAll(
            brightness == Brightness.light ? null : Colors.white,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(
            Colors.transparent,
          ),
          padding: WidgetStatePropertyAll(
            _inputDecorationThemePadding,
          ),
          iconColor: WidgetStatePropertyAll(
            brightness == Brightness.light ? null : Colors.white,
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              color: brightness == Brightness.light ? null : Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          foregroundColor: WidgetStatePropertyAll(
            brightness == Brightness.light ? null : Colors.white,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(
            Colors.transparent,
          ),
        ),
      ),
      scaffoldBackgroundColor: brightness == Brightness.light ? Colors.white : const Color(0xff121212),
      colorScheme: brightness == Brightness.light
          ? ColorScheme(
              brightness: brightness,
              primary: _primaryColor,
              onPrimary: Colors.white,
              secondary: _secondaryColor,
              onSecondary: Colors.white,
              error: Colors.red.shade300,
              onError: Colors.white,
              surface: Colors.white,
              onSurface: Colors.grey.shade300,
              surfaceTint: Colors.white,
            )
          : ColorScheme(
              brightness: brightness,
              primary: _primaryColor,
              onPrimary: Colors.grey,
              secondary: _secondaryColor,
              onSecondary: Colors.grey,
              error: Colors.red.shade300,
              onError: Colors.white,
              surface: const Color(0xff333333),
              onSurface: Colors.grey.shade400,
              surfaceTint: const Color(0xff212121),
            ),
      iconTheme: IconThemeData(
        color: brightness == Brightness.light ? null : Colors.white,
        applyTextScaling: true,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: _primaryColor,
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
          fontFamily: fontFamily,
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: brightness == Brightness.light ? Colors.white : const Color(0xff212121),
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
}

/// Extension methods and properties for the [ThemeData] object.
///
extension GsaThemeExt on ThemeData {
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
    final screenSpecs = screenSpecifications;
    if (screenSpecs.size == null || screenSpecs.ratio == null) {
      return null;
    }
    return Size(screenSpecs.size!.width / screenSpecs.ratio!, screenSpecs.size!.height / screenSpecs.ratio!);
  }

  /// Scale at which the regular elements are being sized.
  ///
  double get elementScale {
    if (GsaRoute.navigatorKey.currentContext == null) return 1;
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
