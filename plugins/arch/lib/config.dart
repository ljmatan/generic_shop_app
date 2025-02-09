import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_services/services.dart';

/// Project-level configuration methods and properties.
///
class GsaConfig {
  const GsaConfig._();

  /// Defines the host client provider.
  ///
  /// App handling, such as the initialisation or content display, is based on this value.
  ///
  static GsaConfigProvider provider = GsaConfigProvider.values.firstWhereOrNull(
        (provider) => provider.name.toLowerCase() == const String.fromEnvironment('gsaProvider').toLowerCase(),
      ) ??
      GsaConfigProvider.demo;

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
  /// To disable the cart feature, a value equaling `false` must be provided during the compile time.
  ///
  static bool cartEnabled = const String.fromEnvironment('gsaCartEnabled').toLowerCase() != 'false';

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

/// App client / checkout process provider.
///
enum GsaConfigProvider {
  /// Demo provider, implemented for app mock data display.
  ///
  demo,

  /// Generic WooCommerce client provider identifier.
  ///
  woocommerce,

  /// Shoe sales client with a custom API system implementation.
  ///
  ivancica,
}

/// Extension methods and properties for the [GsaConfigProvider] object.
///
extension GsaConfigProviderExt on GsaConfigProvider {
  /// Theme properties associated with a provider.
  ///
  ({
    String? fontFamily,
    Color? primary,
    Color? secondary,
    Color? tertiary,
  })? get themeProperties {
    switch (this) {
      case GsaConfigProvider.ivancica:
        return (
          fontFamily: 'Merriweather Sans',
          primary: const Color(0xff8DC63F),
          secondary: const Color(0xff303945),
          tertiary: const Color(0xffF6F9FC),
        );
      default:
        return null;
    }
  }

  /// Curated collection of provider document network resource URLs.
  ///
  ({
    String? termsAndConditions,
    String? privacyPolicy,
    String? cookieNotice,
    String? helpAndFaq,
  }) get documentUrls => (
        termsAndConditions: switch (this) {
          GsaConfigProvider.ivancica => 'https://www.froddo.com/hr/politika-privatnosti-1',
          GsaConfigProvider.demo => null,
          GsaConfigProvider.woocommerce => null,
        },
        privacyPolicy: switch (this) {
          GsaConfigProvider.ivancica => null,
          GsaConfigProvider.demo => null,
          GsaConfigProvider.woocommerce => null,
        },
        cookieNotice: switch (this) {
          GsaConfigProvider.ivancica => null,
          GsaConfigProvider.demo => null,
          GsaConfigProvider.woocommerce => null,
        },
        helpAndFaq: switch (this) {
          GsaConfigProvider.ivancica => 'https://shop.ivancica.hr/pitanja-i-odgovori',
          GsaConfigProvider.demo => null,
          GsaConfigProvider.woocommerce => null,
        }
      );
}
