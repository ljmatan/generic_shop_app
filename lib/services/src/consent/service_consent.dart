import 'package:generic_shop_app/services/services.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:gsa_architecture/gsar.dart';

/// Class responsible for handling any user privacy-related consent requests and statuses.
///
class GsaServiceConsent extends GsarService {
  GsaServiceConsent._();

  static final _instance = GsaServiceConsent._();

  // ignore: public_member_api_docs
  static GsaServiceConsent get instance => _instance() as GsaServiceConsent;

  /// Method responsible for updating the service and display configuration on consent status changes.
  ///
  Future<void> onConsentStatusChanged() async {
    await GsaServiceCache.instance.onCookieConsentAcknowledged();
    await GsarService.revaluateAll();
    GsarRoute.rebuildAll();
  }

  final consentStatus = (mandatoryCookies: () => GsaServiceCacheId.mandatoryCookiesConsent.value,);
}
