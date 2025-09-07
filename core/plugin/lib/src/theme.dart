import 'dart:ui';

/// Theme customisation options for client integrations.
///
class GsaPluginTheme {
  /// Generates an instance of a custom theme object with options specific to an app client.
  ///
  const GsaPluginTheme({
    this.fontFamily,
    this.logoImagePath,
    this.primaryColor,
    this.animatedAppBar = true,
  });

  /// The specified plugin display font family.
  ///
  final String? fontFamily;

  /// Asset or network path of the plugin client logo image.
  ///
  final String? logoImagePath;

  /// The background color for major parts of the app (toolbars, tab bars, etc.).
  ///
  final Color? primaryColor;

  /// Whether the [GsaWidgetAppBar] element is to be animated for the app display.
  ///
  final bool animatedAppBar;
}
