import 'package:generic_shop_app_architecture/gsar.dart';

class GsaServiceAuth extends GsaService {
  GsaServiceAuth._();

  static final _instance = GsaServiceAuth._();

  // ignore: public_member_api_docs
  static GsaServiceAuth get instance => _instance() as GsaServiceAuth;

  @override
  bool get critical => true;
}
