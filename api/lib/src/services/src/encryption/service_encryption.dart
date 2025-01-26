import 'package:generic_shop_app_architecture/gsar.dart';

class GsaaServiceEncryption extends GsarService {
  GsaaServiceEncryption._();

  static final _instance = GsaaServiceEncryption._();

  static GsaaServiceEncryption get instance => _instance() as GsaaServiceEncryption;
}
