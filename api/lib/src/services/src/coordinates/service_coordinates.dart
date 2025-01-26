import 'package:generic_shop_app_architecture/gsa_architecture.dart';

class GsaaServiceCoordinates extends GsarService {
  GsaaServiceCoordinates._();

  static final _instance = GsaaServiceCoordinates._();

  static GsaaServiceCoordinates get instance => _instance() as GsaaServiceCoordinates;

  Future<(double, double)> _findMatching() async {
    return (.0, .0);
  }

  Future<(double, double)> findMatching() async {
    return (.0, .0);
  }
}
