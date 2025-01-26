import 'package:generic_shop_app_architecture/gsar.dart';

/// Linter services with custom code inspection configuration.
///
class GsaaServiceLints extends GsarService {
  GsaaServiceLints._();

  static final _instance = GsaaServiceLints._();

  // ignore: public_member_api_docs
  static GsaaServiceLints get instance => _instance() as GsaaServiceLints;
}
