import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_services/services.dart';

/// Project-level configuration methods and properties.
///
class GsaConfig {
  const GsaConfig._();

  /// Plugin implementation for a specified application client.
  ///
  /// The value defines the host client provider.
  ///
  /// App handling, such as the initialisation or content display, is based on this value.
  ///
  static late GsaPlugin plugin;

  static const _version = String.fromEnvironment('gsaVersion');

  /// Unique build version identification number.
  ///
  static String get version => _version.isEmpty ? '0.0.0.0' : _version;

  /// Defines whether this is a QA / debug build.
  ///
  /// Certain features are enabled only when this value is true.
  ///
  static bool qaBuild = kDebugMode || const String.fromEnvironment('gsaDebugBuild').toLowerCase() == 'true';

  /// If below value is true, data will be mocked instead of fetched from server.
  ///
  static bool mockBuild = const String.fromEnvironment('gsaMockBuild').toLowerCase() == 'true';

  /// Defines whether the app edit mode is enabled.
  ///
  /// With app edit mode, content editing is possible.
  ///
  static bool editMode = const String.fromEnvironment('gsaEditMode').toLowerCase() == 'true';

  /// Whether the client access to the application requires login or registration.
  ///
  static bool requiresAuthentication = const String.fromEnvironment('gsaRequiresAuthentication').toLowerCase() == 'true';

  /// Whether cart and shopping options are enabled.
  ///
  /// A client may opt-in simply for catalog and favourite / bookmark display, for example.
  ///
  /// To disable the cart feature, a value equaling `false` must be provided during the compile time:
  ///
  /// ```dart
  /// flutter run --dart-define gsaCartEnabled=false
  /// ```
  ///
  /// The value can alternatively be adjusted during the application runtime.
  ///
  static bool cartEnabled = const String.fromEnvironment('gsaCartEnabled').toLowerCase() != 'false';

  /// Property defining whether authentication options are available with an app project.
  ///
  /// If the feature is disabled, the user will be allowed to proceed to the app without authentication requirements.
  ///
  /// To disable the feature, a dart-define property can be defined as in below example:
  ///
  /// ```dart
  /// flutter run --dart-define authenticationEnabled=false
  /// ```
  ///
  /// The value can alternatively be adjusted during the application runtime.
  ///
  static bool authenticationEnabled = const String.fromEnvironment('gsaAuthEnabled').toLowerCase() != 'false';

  /// Configuration option defining whether the register option is enabled with the application.
  ///
  /// Certain client integrations may opt-out of registration within the app.
  ///
  /// To disable user registration, a dart-define property can be defined as in below example:
  ///
  /// ```dart
  /// flutter run --dart-define gsaRegistrationEnabled=false
  /// ```
  ///
  /// The value can alternatively be adjusted during the application runtime.
  ///
  static bool registrationEnabled = const String.fromEnvironment('gsaRegistrationEnabled').toLowerCase() != 'false';

  /// Defines whether anonymous user access (guest login) is enabled for a client integration.
  ///
  /// This feature allows the users to proceed to the app contents without authentication.
  ///
  /// To disable guest login, a dart-define property can be defined as in below example:
  ///
  /// ```dart
  /// flutter run --dart-define gsaGuestLoginEnabled=false
  /// ```
  ///
  /// The value can alternatively be adjusted during the application runtime.
  ///
  static bool guestLoginEnabled = const String.fromEnvironment('gsaGuestLoginEnabled').toLowerCase() != 'false';

  static const _gitBranch = String.fromEnvironment('gsaGitBranch');

  /// Git branch this build was compiled from.
  ///
  static String? gitBranch = _gitBranch.isEmpty ? null : _gitBranch;

  /// The specified runtime language notifier.
  ///
  static final languageNotifier = ValueNotifier<GsaServiceI18NLanguage>(GsaServiceI18NLanguage.en);

  /// The specified runtime language.
  ///
  static GsaServiceI18NLanguage get language => languageNotifier.value;

  /// The specified runtime display currency.
  ///
  static final currencyNotifier = GsaModelPrice.conversionFactorNotifier;

  /// The specified runtime currency.
  ///
  static GsaModelPriceCurrencyType get currency => currencyNotifier.value;

  /// Initialise the runtime resources with the specified parameters.
  ///
  static Future<void> init() async {
    // Configure the visual display.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Allocate the application runtime resources according to the given configuration.
    GsaServiceAppTrackingTransparency.instance;
    GsaServiceAuth.instance;
    GsaServiceBarcodeGenerator.instance;
    GsaServiceBookmarks.instance;
    GsaServiceCache.instance;
    GsaServiceCalendar.instance;
    GsaServiceCompress.instance;
    GsaServiceConsent.instance;
    GsaServiceDebug.instance;
    GsaServiceEncryption.instance;
    GsaServiceI18N.instance;
    GsaServiceInputValidation.instance;
    GsaServiceLocation.instance;
    GsaServiceLogging.instance;
    GsaServiceMock.instance;
    GsaServiceSearch.instance;
    GsaServiceTracking.instance;
    GsaServiceUrlLauncher.instance;
    GsaServiceBarcodeGenerator.instance;
    await GsaServiceCache.instance.init();
    await GsaService.initAll();
    GsaDataCheckout.instance;
    GsaDataMerchant.instance;
    GsaDataSaleItems.instance;
    GsaDataUser.instance;
    await GsaData.initAll();
  }
}

/// A collection of application client integration identifiers.
///
/// Used primarily for identifying of the current client during the app runtime.
///
enum GsaClient {
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
  /// Widget constructor with body ensuring [GsaConfig.plugin] information setup on initialisation.
  ///
  GsaPlugin() {
    try {
      GsaConfig.plugin;
    } catch (e) {
      GsaConfig.plugin = this;
    }
  }

  /// The client specified for this plugin integration.
  ///
  GsaClient get client;

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

  /// The specified plugin display font family.
  ///
  String? get fontFamily;

  /// Asset or network path of the plugin client logo image.
  ///
  String? get logoImagePath;

  /// The background color for major parts of the app (toolbars, tab bars, etc.).
  ///
  Color? get primaryColor;

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
  String? Function(String?)? get passwordValidator {
    return null;
  }

  /// Method implemented for retrieving promotional content displayed on the dashboard.
  ///
  Future<List<GsaModelPromoBanner>> Function()? get getPromoBanners {
    return null;
  }
}
