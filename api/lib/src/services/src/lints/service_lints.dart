import 'package:generic_shop_app_api/src/services/services.dart';

/// Linter services with custom code inspection configuration.
///
class GsaaServiceLints extends GsaaService {
  GsaaServiceLints._();

  static final _instance = GsaaServiceLints._();

  // ignore: public_member_api_docs
  static GsaaServiceLints get instance => _instance() as GsaaServiceLints;
}
