import 'package:generic_shop_app_api/src/services/services.dart';

class GsaaServiceEncryption extends GsaaService {
  GsaaServiceEncryption._();

  static final _instance = GsaaServiceEncryption._();

  static GsaaServiceEncryption get instance => _instance() as GsaaServiceEncryption;
}
