import 'package:generic_shop_app_architecture/gsar.dart';

/// User activity tracking service.
///
class GsaServiceTracking extends GsaService {
  GsaServiceTracking._();

  static final _instance = GsaServiceTracking._();

  /// Globally-accessible singleton class instance.
  ///
  static GsaServiceTracking get instance => _instance() as GsaServiceTracking;

  /// Records a log entry implemented by the tracking service.
  ///
  Future<void> logEvent() async {}

  /// Methods used for logging of cart-related events.
  ///
  final cart = const _GsaServiceTrackingCart();

  /// Methods used for logging of route-related events.
  ///
  final route = const _GsaServiceTrackingRoute();

  /// Methods used for logging of device-related events.
  ///
  final device = const _GsaServiceTrackingDevice();
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
