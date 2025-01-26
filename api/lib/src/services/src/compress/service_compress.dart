import 'package:generic_shop_app_architecture/gsar.dart';

class GsaaServiceCompress extends GsarService {
  GsaaServiceCompress._();

  static final _instance = GsaaServiceCompress._();

  static GsaaServiceCompress get instance => _instance() as GsaaServiceCompress;
}
