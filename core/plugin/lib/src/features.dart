part of '../plugin.dart';

/// A collection of feature flags specific to the plugin implementation.
///
class GsaPluginFeatures {
  /// Core feature flags for plugin integration.
  ///
  GsaPluginFeatures({
    this.cart = true,
    this.bookmarks = true,
    this.authentication = true,
    this.registration = true,
    this.guestLogin = true,
    this.currencyConversion = true,
  });

  /// Whether cart and shopping options are enabled.
  ///
  /// A client may opt-in simply for catalog and favourite / bookmark display.
  ///
  bool cart;

  /// Whether bookmark options are enabled.
  ///
  bool bookmarks;

  /// Property defining whether authentication options are available with an app project.
  ///
  /// If the feature is disabled, the user will be allowed to proceed to the app without authentication requirements.
  ///
  bool authentication;

  /// Configuration option defining whether the register option is enabled with the application.
  ///
  /// Certain client integrations may opt-out of registration within the app.
  ///
  bool registration;

  /// Defines whether anonymous user access (guest login) is enabled for a client integration.
  ///
  /// This feature allows the users to proceed to the app contents without authentication.
  ///
  bool guestLogin;

  /// Defines whether currrency conversion or switch is enabled.
  ///
  bool currencyConversion;
}
