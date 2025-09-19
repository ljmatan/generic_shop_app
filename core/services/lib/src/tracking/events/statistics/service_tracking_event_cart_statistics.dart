part of '../../service_tracking.dart';

class _GsaServiceTrackingEventCartStatistics extends _GsaServiceTrackingEventCart {
  _GsaServiceTrackingEventCartStatistics._() : super._();

  static final _instance = _GsaServiceTrackingEventCartStatistics._();

  Future<void> logItemAdd() async {}

  Future<void> logItemRemove() async {}

  Future<void> logItemUpdateAmount() async {}
}
