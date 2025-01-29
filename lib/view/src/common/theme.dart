import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app/config.dart';

/// The default theme configuration for the application project.
///
class GsaTheme {
  const GsaTheme._();

  /// The setting indicating the current brightness mode of the host platform.
  /// If the platform has no preference, [platformBrightness] defaults to [Brightness.light].
  ///
  static Brightness platformBrightness = PlatformDispatcher.instance.platformBrightness;

  static Color get _primaryColor {
    if (GsaConfig.provider.primaryColor != null) {
      return GsaConfig.provider.primaryColor!;
    }
    return platformBrightness == Brightness.light ? (1 == 1 ? const Color(0xff67bc2a) : const Color(0xffB7C9E2)) : const Color(0xff63183f);
  }

  static Color get _secondaryColor {
    return platformBrightness == Brightness.light ? const Color(0xff63183f) : const Color(0xffB7C9E2);
  }

  /// Getter method for the [ThemeData] implementation, specified according to the [platformBrightness] value.
  ///
  static ThemeData get data {
    return ThemeData(
      primaryColor: _primaryColor,
      fontFamily: 'Quicksand',
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      textTheme: platformBrightness == Brightness.light
          ? Typography.blackRedwoodCity.copyWith(
              bodyMedium: const TextStyle(
                decorationColor: Colors.grey,
              ),
            )
          : Typography.whiteRedwoodCity.copyWith(
              bodyMedium: const TextStyle(
                decorationColor: Colors.grey,
              ),
            ),
      dividerColor: Colors.grey.shade200,
      dividerTheme: const DividerThemeData(thickness: .5),
      scaffoldBackgroundColor: platformBrightness == Brightness.light ? Colors.white : const Color(0xff121212),
      colorScheme: platformBrightness == Brightness.light
          ? ColorScheme(
              brightness: platformBrightness,
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
              brightness: platformBrightness,
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
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      cardTheme: platformBrightness == Brightness.light
          ? CardTheme(
              elevation: 0,
              color: Colors.white,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.grey.withOpacity(.2),
                ),
              ),
            )
          : CardTheme(
              elevation: 0,
              color: const Color(0xff212121),
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.grey.withOpacity(.2),
                ),
              ),
            ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(_primaryColor),
        trackColor: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.selected) ? _primaryColor.withOpacity(.6) : null,
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
  static SystemUiOverlayStyle get systemUiOverlayStyle {
    return platformBrightness == Brightness.light
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
