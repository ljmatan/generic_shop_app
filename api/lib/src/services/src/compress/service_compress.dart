import 'package:generic_shop_app_api/src/services/services.dart';

class GsaaServiceCompress extends GsaaService {
  GsaaServiceCompress._();

  static final _instance = GsaaServiceCompress._();

  static GsaaServiceCompress get instance => _instance() as GsaaServiceCompress;
}
