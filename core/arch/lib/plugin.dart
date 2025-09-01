part of 'config.dart';

/// A collection of application client integration identifiers.
///
/// Used primarily for identifying of the current client during the app runtime.
///
enum GsaPluginClient {
  demo,
  fitnessTracker,
  froddoB2b,
  froddoB2c;
}

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

  /// Method implemented for managing and initialisationv of the application resources.
  ///
  Future<void> init();

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

  /// Curated collection of provider document network resource URLs.
  ///
  ({
    String? termsAndConditions,
    String? privacyPolicy,
    String? cookieNotice,
    String? helpAndFaq,
  })? get documentUrls {
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
  })? get loginWithUsernameAndPassword {
    return null;
  }

  /// Method used for validating password input on the user authentication screens.
  ///
  String? Function(
    String?, {
    GsaServiceI18NModelTranslatedValue? errorMessage,
  })? get passwordValidator {
    return null;
  }

  /// Used for product purchase intent registration.
  ///
  Future<void> Function(
    BuildContext context, {
    required GsaModelSaleItem item,
  })? get addToCart {
    return null;
  }

  /// Method optionally implemented for starting the checkout process from the cart page.
  ///
  Future<void> Function(
    BuildContext context,
  )? get startCheckout {
    return null;
  }

  /// Method implemented for retrieving promotional content displayed on the dashboard.
  ///
  Future<List<GsaModelPromoBanner>> Function()? get getPromoBanners {
    return null;
  }
}

/// Collection of cookie information related to a client integration.
///
class GsaPluginCookies {
  /// Generates an instance of the object,
  /// marking the cookie requirement with [bool] values.
  ///
  GsaPluginCookies({
    this.mandatory = true,
    this.functional = true,
    required this.marketing,
    required this.statistical,
  });

  /// Cookie category identifier.
  ///
  final bool mandatory, functional, marketing, statistical;
}

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
