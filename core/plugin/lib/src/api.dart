part of '../plugin.dart';

/// A collection of API methods specific to the plugin implementation.
///
/// Common or shared API implementations are defined with this class.
///
class GsaPluginApi {
  /// Core API functionalities for plugin integration.
  ///
  GsaPluginApi({
    this.loginWithUsernameAndPassword,
    this.passwordValidator,
    this.getPromoBanners,
    this.addToCart,
    this.startCheckout,
  });

  /// Method used with login screen implementations for logging in a user with specified credentials.
  ///
  final Future<void> Function({
    required String username,
    required String password,
  })?
  loginWithUsernameAndPassword;

  /// Method used for validating password input on the user authentication screens.
  ///
  String? Function(
    String? input, {
    String? errorMessage,
  })?
  passwordValidator;

  /// Method implemented for retrieving promotional content displayed on the dashboard.
  ///
  Future<List<GsaModelPromoBanner>> Function()? getPromoBanners;

  /// Used for product purchase intent registration.
  ///
  Future<void> Function(
    BuildContext context, {
    required GsaModelSaleItem item,
  })?
  addToCart;

  /// Method optionally implemented for starting the checkout process from the cart page.
  ///
  Future<void> Function(
    BuildContext context,
  )?
  startCheckout;
}
