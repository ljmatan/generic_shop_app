import 'package:generic_shop_app_architecture/gsa_architecture.dart';

class GsaaServiceCompress extends GsarService {
  GsaaServiceCompress._();

  static final _instance = GsaaServiceCompress._();

  static GsaaServiceCompress get instance => _instance() as GsaaServiceCompress;
}
