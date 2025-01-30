import 'package:generic_shop_app/services/services.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Class responsible for handling any user privacy-related consent requests and statuses.
///
class GsaServiceConsent extends GsarService {
  GsaServiceConsent._() {
    _mandatoryConsentPreviouslyConfirmed = hasMandatoryConsent;
  }

  static final _instance = GsaServiceConsent._();

  /// Globally-accessible singleton class instance.
  ///
  static GsaServiceConsent get instance => _instance() as GsaServiceConsent;

  /// Defines whether the mandatory consent has been given.
  ///
  /// If the consent has been given, the user may proceed with using the application.
  ///
  bool get hasMandatoryConsent {
    return consentStatus.mandatoryCookies() != null;
  }

  /// Determines whether the consent has been given at a previous point.
  ///
  bool? _mandatoryConsentPreviouslyConfirmed;

  /// Method responsible for updating the service and display configuration on consent status changes.
  ///
  Future<void> onConsentStatusChanged() async {
    if (_mandatoryConsentPreviouslyConfirmed == true) {
      await GsaServiceCache.instance.onCookieConsentAcknowledged();
      await GsarService.revaluateAll();
      GsarRoute.rebuildAll();
    } else {
      _mandatoryConsentPreviouslyConfirmed = true;
    }
  }

  /// Property with which all of the defined consent statuses can be accessed.
  ///
  final consentStatus = (
    mandatoryCookies: () => GsaServiceCacheId.mandatoryCookiesConsent.value,
    marketingCookies: () => GsaServiceCacheId.marketingCookiesConsent.value,
    functionalCookies: () => GsaServiceCacheId.functionalCookiesConsent.value,
    statisticalCookies: () => GsaServiceCacheId.statisticalCookiesConsent.value,
  );
}
