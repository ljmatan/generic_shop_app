import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_services/services.dart';

part 'plugin.dart';

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

  static const _gitBranch = String.fromEnvironment('gsaGitBranch');

  /// Git branch this build was compiled from.
  ///
  static String? gitBranch = _gitBranch.isEmpty ? null : _gitBranch;

  /// The specified runtime language notifier.
  ///
  static final languageNotifier = ValueNotifier<GsaServiceI18NLanguage>(
    GsaServiceI18NLanguage.enUs,
  );

  /// The specified runtime language.
  ///
  static GsaServiceI18NLanguage get language => languageNotifier.value;

  /// The specified runtime display currency.
  ///
  static final currencyNotifier = GsaModelPrice.conversionFactorNotifier;

  /// The specified runtime currency.
  ///
  static GsaModelPriceCurrencyType get currency => currencyNotifier.value;

  /// Whether cart and shopping options are enabled.
  ///
  /// A client may opt-in simply for catalog and favourite / bookmark display, for example.
  ///
  /// To disable the cart feature,
  /// a value equaling `false` must be provided during the compile time:
  ///
  /// ```dart
  /// flutter run --dart-define gsaCartEnabled=false
  /// ```
  ///
  /// The value can alternatively be adjusted during the application runtime.
  ///
  static bool cartEnabled = const String.fromEnvironment('gsaCartEnabled').toLowerCase() != 'false';

  /// Whether bookmark options are enabled.
  ///
  /// To disable the bookmark feature,
  /// a value equaling `false` must be provided during the compile time:
  ///
  /// ```dart
  /// flutter run --dart-define gsaBookmarksEnabled=false
  /// ```
  ///
  /// The value can alternatively be adjusted during the application runtime.
  ///
  static bool bookmarksEnabled = const String.fromEnvironment('gsaBookmarksEnabled').toLowerCase() != 'false';

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

  /// Defines whether currrency conversion or switch is enabled.
  ///
  /// To update the property, it can be set during the runtime:
  ///
  /// ```dart
  /// GsaConfig.currencyConversionEnabled = false;
  /// ```
  ///
  static bool currencyConversionEnabled = true;

  /// Initialise the runtime resources with the specified parameters.
  ///
  static Future<void> init() async {
    // Configure the visual display.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Allocate the application runtime resources according to the given configuration.
    GsaServiceAppTrackingTransparency.instance;
    GsaServiceAuth.instance;
    GsaServiceBookmarks.instance;
    GsaServiceCache.instance;
    GsaServiceCalendar.instance;
    GsaServiceClipboard.instance;
    GsaServiceCompress.instance;
    GsaServiceConsent.instance;
    GsaServiceDebug.instance;
    GsaServiceDeviceInfo.instance;
    GsaServiceEncryption.instance;
    GsaServiceI18N.instance;
    GsaServiceInputValidation.instance;
    GsaServiceLocation.instance;
    GsaServiceLogging.instance;
    GsaServiceMock.instance;
    GsaServicePermissions.instance;
    GsaServiceShare.instance;
    GsaServiceSearch.instance;
    GsaServiceTracking.instance;
    GsaServiceUrlLauncher.instance;
    await GsaServiceCache.instance.init();
    await GsaService.initAll();
    GsaDataCheckout.instance;
    GsaDataMerchant.instance;
    GsaDataSaleItems.instance;
    GsaDataUser.instance;
    await GsaData.initAll();
  }
}
