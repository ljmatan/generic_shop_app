import 'package:generic_shop_app_architecture/gsar.dart';

class GsaServiceCoordinates extends GsaService {
  GsaServiceCoordinates._();

  static final _instance = GsaServiceCoordinates._();

  static GsaServiceCoordinates get instance => _instance() as GsaServiceCoordinates;

  Future<(double, double)> _findMatching() async {
    return (.0, .0);
  }

  Future<(double, double)> findMatching() async {
    return (.0, .0);
  }
}
