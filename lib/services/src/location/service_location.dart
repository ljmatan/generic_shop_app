import 'package:generic_shop_app/services/services.dart';

/// Linter services with custom code inspection configuration.
///
class GsaServiceLocation extends GsaService {
  GsaServiceLocation._();

  static final _instance = GsaServiceLocation._();

  // ignore: public_member_api_docs
  static GsaServiceLocation get instance => _instance() as GsaServiceLocation;
}
