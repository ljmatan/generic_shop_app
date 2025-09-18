import 'package:generic_shop_app_architecture/arch.dart';

class GsaServiceEncryption extends GsaService {
  GsaServiceEncryption._();

  static final _instance = GsaServiceEncryption._();

  static GsaServiceEncryption get instance => _instance() as GsaServiceEncryption;
}
