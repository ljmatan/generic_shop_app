import 'package:generic_shop_app_architecture/gsar.dart';

class GsaServiceEncryption extends GsaService {
  GsaServiceEncryption._();

  static final _instance = GsaServiceEncryption._();

  static GsaServiceEncryption get instance => _instance() as GsaServiceEncryption;
}
