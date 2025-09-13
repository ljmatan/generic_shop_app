import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_architecture/arch.dart';

/// Project-level configuration methods and properties.
///
class GsaConfig {
  const GsaConfig._();

  static const _version = String.fromEnvironment('gsaVersion');

  /// Unique build version identification number.
  ///
  static String get version => _version.isEmpty ? '0.0.0.0' : _version;

  /// Defines whether this is a QA / debug build.
  ///
  /// Certain features are enabled only when this value is true.
  ///
  static bool qaBuild = kDebugMode || const String.fromEnvironment('gsaDebugBuild').toLowerCase() == 'true';

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

  /// Initialise the runtime resources with the specified parameters.
  ///
  static Future<void> init(BuildContext context) async {
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
    GsaServicePermissions.instance;
    GsaServiceShare.instance;
    GsaServiceSslOverride.instance;
    GsaServiceSearch.instance;
    GsaServiceTracking.instance;
    GsaServiceUrlLauncher.instance;
    final plugin = GsaPlugin.of(context);
    GsaServiceCache.instance.cacheIdPrefix = plugin.id;
    await GsaServiceCache.instance.init();
    await GsaService.initAll();
    GsaDataCheckout.instance;
    GsaDataMerchant.instance;
    GsaDataSaleItems.instance;
    GsaDataUser.instance;
    await GsaData.initAll();
  }
}
