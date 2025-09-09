part of '../plugin.dart';

/// Theme customisation options for client integrations.
///
/// The class defines a list of options which can be customised with client implementations.
///
class GsaPluginTheme extends GsaTheme {
  /// Generates an instance of a custom theme object with options specific to an app client.
  ///
  GsaPluginTheme({
    super.platform,
    super.logoImagePath,
    super.animatedAppBar = true,
    super.brightness,
    super.primaryColor,
    super.secondaryColor,
    super.fontFamily,
    super.systemUiOverlayStyle,
    super.borderRadius,
    super.inputDecorationTheme,
    super.roundedRectangleBorder,
  });

  /// Method used for instantiating a new class instance with custom-defined properties.
  ///
  @override
  GsaPluginTheme copyWith({
    TargetPlatform? platform,
    String? logoImagePath,
    bool? animatedAppBar,
    Brightness? brightness,
    Color? primaryColor,
    Color? secondaryColor,
    String? fontFamily,
    SystemUiOverlayStyle? systemUiOverlayStyle,
    BorderRadius? borderRadius,
    InputDecorationTheme? inputDecorationTheme,
    RoundedRectangleBorder? roundedRectangleBorder,
  }) {
    return GsaPluginTheme(
      platform: platform ?? this.platform,
      logoImagePath: logoImagePath ?? this.logoImagePath,
      animatedAppBar: animatedAppBar ?? this.animatedAppBar,
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      fontFamily: fontFamily ?? this.fontFamily,
      systemUiOverlayStyle: systemUiOverlayStyle ?? this.systemUiOverlayStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
      roundedRectangleBorder: roundedRectangleBorder ?? this.roundedRectangleBorder,
    );
  }
}
