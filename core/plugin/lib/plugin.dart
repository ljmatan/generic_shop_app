import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';

export 'src/api.dart';
export 'src/client.dart';
export 'src/cookies.dart';
export 'src/documents.dart';
export 'src/theme.dart';

/// The application client implementations base service definitions.
///
/// These definitions are required to be implemented in order to comply with the
/// application architecture, which may be based off of various client integrations.
///
abstract class GsaPlugin {
  /// Marks this plugin instance as the active application client.
  ///
  void configureClient() {
    GsaConfig.plugin = this;
  }

  /// The client specified for this plugin integration.
  ///
  GsaPluginClient get client;

  /// The identifier for the plugin project specified in the `pubspec.yaml` file.
  ///
  String get id;

  /// Method implemented for managing and initialisation of the application resources.
  ///
  /// The method is called by the [init] method, and it's invocation won't be repeated if
  /// the [loadData] method call is unsuccessful.
  ///
  /// Used for setting up the plugin services and other relevant application resources.
  ///
  Future<void> setupService() async {}

  /// Method used for fetching runtime data from the backend or any other relevant sources.
  ///
  /// The method is called by the [init] method,
  /// and is separated from the [setupService] method in order to differentiate it as a
  /// "likely throwable" function.
  ///
  Future<void> fetchData() async {}

  /// Property defining whether the [setupService] method has been executed successfully.
  ///
  bool _setupExecuted = false;

  /// Method invoked on the application splash screen.
  ///
  /// Invokes the [setupService] and [fetchData] method,
  /// while verifying the [setupService] method is not invoked multiple times if not necessary.
  ///
  /// [forceSetup] parameter can be optionally included in order to invoke the [setupService] method
  /// on each of the [init] function call.
  ///
  Future<void> init([
    bool forceSetup = false,
  ]) async {
    if (forceSetup || !_setupExecuted) {
      await setupService();
      _setupExecuted = true;
    }
    await fetchData();
  }

  /// App screen specified for display after the splash and user consent screens.
  ///
  GsaRoute Function() get initialRoute;

  /// A collection of routes specific to the plugin implementation.
  ///
  List<GsaRouteType>? get routes;

  /// Getter method providing information on the used cookies.
  ///
  GsaPluginCookies get enabledCookieTypes;

  /// Theme properties specified for this plugin integration.
  ///
  GsaPluginTheme get theme {
    return const GsaPluginTheme();
  }

  /// Collection of translations implemented for this plugin integration.
  ///
  List<List<GsaServiceI18NBaseTranslations>> get translations;

  /// Document resource location specifications.
  ///
  /// See [GsaPluginDocuments] for more information.
  ///
  GsaPluginDocuments? get documentUrls {
    return null;
  }

  /// Widget specified for display above the [MaterialApp.builder.child] object.
  ///
  Widget? get overlayBuilder {
    return null;
  }

  /// Method used with login screen implementations for logging in a user with [username] and [password].
  ///
  Future<void> Function({
    required String username,
    required String password,
  })?
  get loginWithUsernameAndPassword {
    return null;
  }

  /// Method used for validating password input on the user authentication screens.
  ///
  String? Function(
    String?, {
    GsaServiceI18NModelTranslatedValue? errorMessage,
  })?
  get passwordValidator {
    return null;
  }

  /// Used for product purchase intent registration.
  ///
  Future<void> Function(
    BuildContext context, {
    required GsaModelSaleItem item,
  })?
  get addToCart {
    return null;
  }

  /// Method optionally implemented for starting the checkout process from the cart page.
  ///
  Future<void> Function(
    BuildContext context,
  )?
  get startCheckout {
    return null;
  }

  /// Method implemented for retrieving promotional content displayed on the dashboard.
  ///
  Future<List<GsaModelPromoBanner>> Function()? get getPromoBanners {
    return null;
  }
}
