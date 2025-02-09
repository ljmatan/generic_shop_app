import 'package:generic_shop_app_architecture/gsar.dart';

class GsaServiceCompress extends GsaService {
  GsaServiceCompress._();

  static final _instance = GsaServiceCompress._();

  static GsaServiceCompress get instance => _instance() as GsaServiceCompress;
}
