import 'package:generic_shop_app_architecture/gsar.dart';

/// User activity tracking service.
///
class GsaServiceTracking extends GsarService {
  GsaServiceTracking._();

  static final _instance = GsaServiceTracking._();

  // ignore: public_member_api_docs
  static GsaServiceTracking get instance => _instance() as GsaServiceTracking;

  Future<void> logEvent() async {}

  final cart = const _GsaServiceTrackingCart();

  final route = const _GsaServiceTrackingRoute();

  final device = const _GsaServiceTrackingRoute();
}

class _GsaServiceTrackingCart {
  const _GsaServiceTrackingCart();

  Future<void> logItemAdd() async {}

  Future<void> logItemRemove() async {}

  Future<void> logItemUpdateAmount() async {}
}

class _GsaServiceTrackingRoute {
  const _GsaServiceTrackingRoute();

  Future<void> logRouteView() async {}

  Future<void> logRouteInactive() async {}

  Future<void> logRouteExit() async {}
}

class _GsaServiceTrackingDevice {
  const _GsaServiceTrackingDevice();

  Future<void> logRouteView() async {}

  Future<void> logRouteInactive() async {}

  Future<void> logRouteExit() async {}
}
