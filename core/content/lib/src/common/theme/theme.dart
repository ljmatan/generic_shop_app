import 'dart:math';
import 'dart:ui' as dart_ui;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_content/content.dart';

part 'defaults.dart';
part 'text_styles.dart';
part 'wrapper.dart';

/// The default theme configuration for the application project.
///
class GsaTheme {
  /// Default theme constructor with customisation options specified as parameters.
  ///
  /// If no such parameters are provided,
  /// the constructor fetches and applies any default or cached theme choices.
  ///
  GsaTheme({
    this.platform,
    this.logoImagePath,
    this.animatedAppBar = true,
    Brightness? brightness,
    Color? primaryColor,
    Color? secondaryColor,
    String? fontFamily,
    SystemUiOverlayStyle? systemUiOverlayStyle,
    BorderRadius? borderRadius,
    InputDecorationTheme? inputDecorationTheme,
    RoundedRectangleBorder? roundedRectangleBorder,
  }) {
    this.brightness = brightness ?? _brightness;
    this.primaryColor = primaryColor ?? _primaryColor;
    this.secondaryColor = secondaryColor ?? _secondaryColor;
    this.fontFamily = fontFamily ?? _fontFamily;
    this.systemUiOverlayStyle = systemUiOverlayStyle ?? _systemUiOverlayStyle;
    this.borderRadius = borderRadius ?? _borderRadius;
    this.inputDecorationTheme = inputDecorationTheme ?? _inputDecorationTheme;
    this.roundedRectangleBorder = roundedRectangleBorder ?? _roundedRectangleBorder;
  }

  /// The platform that user interaction should adapt to target.
  ///
  TargetPlatform? platform;

  /// Asset or network path of the plugin client logo image.
  ///
  String? logoImagePath;

  /// Whether the [GsaWidgetAppBar] element is to be animated for the app display.
  ///
  bool animatedAppBar;

  /// The setting indicating the current brightness mode of the host platform.
  ///
  /// If the platform has no preference, the value defaults to [Brightness.light].
  ///
  late Brightness brightness;

  /// The background color for major parts of the app (e.g., toolbars or tab bars).
  ///
  late Color primaryColor;

  /// Color used for less prominent components in the UI.
  ///
  late Color secondaryColor;

  /// The name of the font to use when painting the text.
  ///
  late String fontFamily;

  /// Specifies a preference for the style of the system overlays.
  ///
  late SystemUiOverlayStyle systemUiOverlayStyle;

  /// Border radius value applied to elements such as [Card], [OutlinedButton], etc.
  ///
  late BorderRadius borderRadius;

  /// Defines the default appearance of the [InputDecorator] widgets.
  ///
  late InputDecorationTheme inputDecorationTheme;

  /// Specifications for a default rectangular border with rounded corners.
  ///
  late RoundedRectangleBorder roundedRectangleBorder;

  /// Getter method for the [ThemeData] implementation.
  ///
  ThemeData get data {
    return ThemeData(
      platform: platform,
      brightness: brightness,
      primaryColor: primaryColor,
      fontFamily: fontFamily,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: inputDecorationTheme,
        menuStyle: MenuStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
        ),
      ),
      inputDecorationTheme: inputDecorationTheme,
      textTheme: brightness == Brightness.light
          ? TextTheme(
              bodySmall: TextStyle(
                color: Colors.grey.shade600,
              ),
              bodyMedium: TextStyle(
                color: Colors.grey.shade900,
              ),
              titleLarge: TextStyle(
                color: primaryColor,
              ),
              titleMedium: TextStyle(
                color: primaryColor,
              ),
              titleSmall: TextStyle(
                color: primaryColor,
              ),
            )
          : TextTheme(
              bodySmall: const TextStyle(
                color: Colors.grey,
              ),
              bodyMedium: const TextStyle(
                color: Colors.grey,
              ),
              titleLarge: TextStyle(
                color: primaryColor,
              ),
              titleMedium: TextStyle(
                color: primaryColor,
              ),
              titleSmall: TextStyle(
                color: primaryColor,
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
            roundedRectangleBorder,
          ),
          padding: WidgetStatePropertyAll(
            _inputDecorationThemePadding,
          ),
          iconColor: WidgetStatePropertyAll(
            brightness == Brightness.light ? null : Colors.white,
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontFamily: fontFamily,
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
            roundedRectangleBorder,
          ),
          padding: WidgetStatePropertyAll(
            _inputDecorationThemePadding,
          ),
          iconColor: WidgetStatePropertyAll(
            brightness == Brightness.light ? null : Colors.white,
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontFamily: fontFamily,
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
              fontFamily: fontFamily,
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
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontFamily: fontFamily,
              color: brightness == Brightness.light ? null : Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      scaffoldBackgroundColor: brightness == Brightness.light ? Colors.white : const Color(0xff121212),
      colorScheme: brightness == Brightness.light
          ? ColorScheme(
              brightness: brightness,
              primary: primaryColor,
              onPrimary: Colors.white,
              secondary: secondaryColor,
              onSecondary: Colors.white,
              error: Colors.red.shade300,
              onError: Colors.white,
              surface: Colors.white,
              onSurface: Colors.grey.shade200,
              surfaceTint: Colors.white,
            )
          : ColorScheme(
              brightness: brightness,
              primary: primaryColor,
              onPrimary: Colors.grey,
              secondary: secondaryColor,
              onSecondary: Colors.grey,
              error: Colors.red.shade700,
              onError: Colors.white,
              surface: const Color(0xff333333),
              onSurface: Colors.grey.shade300,
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
        backgroundColor: primaryColor,
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
        thumbColor: WidgetStatePropertyAll(primaryColor),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? primaryColor.withValues(alpha: .6) : null,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Color.lerp(primaryColor, Colors.white, .4),
      ),
      tooltipTheme: const TooltipThemeData(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        showDuration: Duration(seconds: 10),
      ),
    );
  }

  /// Used to scale the incoming font size by multiplying it with the given text scale factor.
  ///
  TextScaler textScaler({
    BuildContext? context,
    ({
      double scale,
      double width,
    })? screenSpecs,
  }) {
    if (context == null && screenSpecs == null) {
      throw Exception(
        'Either context or screenSpecs property must be provided.',
      );
    }
    final screenWidth = screenSpecs?.width ?? MediaQuery.of(context!).size.width;
    final scale = screenSpecs?.scale ?? MediaQuery.of(context!).textScaler.scale(1);
    return TextScaler.linear(
      scale *
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

  /// Returns the nearest ancestor widget of [GsaThemeWrapper] type.
  ///
  static GsaThemeWrapper of(BuildContext context) {
    GsaThemeWrapper? themeWrapper = context.findAncestorWidgetOfExactType<GsaThemeWrapper>();
    if (themeWrapper == null) {
      context.visitAncestorElements(
        (element) {
          if (element.widget is GsaThemeWrapper) {
            themeWrapper = element.widget as GsaThemeWrapper;
            return false;
          }
          return true;
        },
      );
    }
    if (themeWrapper == null) {
      throw Exception(
        'Theme wrapper not found in element tree.',
      );
    }
    return themeWrapper!;
  }
}
