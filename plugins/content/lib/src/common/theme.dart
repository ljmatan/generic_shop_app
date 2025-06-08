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
    this.plugin,
  }) : _plugin = plugin ?? GsaConfig.provider.plugin;

  /// Optional client definition of the specified plugin integration.
  ///
  final GsaPlugin? plugin;

  /// Specified client plugin integration,
  /// optionally derived from the [plugin] property,
  /// defaulting to [GsaConfig.provider.plugin].
  ///
  final GsaPlugin _plugin;

  /// Globally-accessible class instance.
  ///
  static final instance = GsaTheme();

  /// The setting indicating the current brightness mode of the host platform.
  /// If the platform has no preference, [platformBrightness] defaults to [Brightness.light].
  ///
  static Brightness platformBrightness = dart_ui.PlatformDispatcher.instance.platformBrightness;

  Color get _primaryColor {
    if (_plugin.themeProperties?.primary != null) {
      return _plugin.themeProperties!.primary!;
    }
    if (platformBrightness == Brightness.light) {
      return const Color(0xff67bc2a);
    } else {
      return const Color(0xff63183f);
    }
  }

  Color get _secondaryColor {
    if (_plugin.themeProperties?.secondary != null) {
      return _plugin.themeProperties!.secondary!;
    }
    if (platformBrightness == Brightness.light) {
      return const Color(0xff63183f);
    } else {
      return const Color(0xffB7C9E2);
    }
  }

  String get _fontFamily => _plugin.themeProperties?.fontFamily ?? 'Quicksand';

  /// Getter method for the [ThemeData] implementation, specified according to the [platformBrightness] value.
  ///
  ThemeData get data {
    return ThemeData(
      primaryColor: _primaryColor,
      fontFamily: _fontFamily,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      textTheme: platformBrightness == Brightness.light
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
              tertiary: _plugin.themeProperties?.tertiary,
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
              tertiary: _plugin.themeProperties?.tertiary,
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
      cardTheme: platformBrightness == Brightness.light
          ? CardThemeData(
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
          : CardThemeData(
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
  SystemUiOverlayStyle get systemUiOverlayStyle {
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
