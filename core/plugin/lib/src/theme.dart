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
}
