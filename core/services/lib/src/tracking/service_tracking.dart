import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';

part 'models/service_tracking_model_event.dart';
part 'events/service_tracking_event_cart.dart';
part 'events/service_tracking_event_engagement.dart';
part 'events/marketing/service_tracking_event_cart_marketing.dart';
part 'events/marketing/service_tracking_event_engagement_marketing.dart';
part 'events/statistics/service_tracking_event_cart_statistics.dart';
part 'events/statistics/service_tracking_event_engagement_statistics.dart';

/// User activity tracking service.
///
class GsaServiceTracking extends GsaService {
  GsaServiceTracking._();

  static final _instance = GsaServiceTracking._();

  /// Globally-accessible singleton class instance.
  ///
  static GsaServiceTracking get instance => _instance() as GsaServiceTracking;

  @override
  Future<void> init(BuildContext context) async {
    await super.init(context);
    _GsaServiceTrackingEventEngagementMarketing._instance;
    _GsaServiceTrackingEventCartMarketing._instance;
    _GsaServiceTrackingEventEngagementStatistics._instance;
    _GsaServiceTrackingEventCartStatistics._instance;
  }

  /// Records a log entry to the local device storage.
  ///
  /// The method will only run if the user consent has been given.
  ///
  Future<void> _logEvent(
    GsaServiceTrackingModelEvent log,
  ) async {
    if (log.statistics && GsaServiceConsent.instance.consentStatus.statisticsCookies() == true ||
        log.marketing && GsaServiceConsent.instance.consentStatus.marketingCookies() == true) {
      await executeAsync(
        () async {},
      );
    }
  }

  /// Methods used for logging of user engagement events.
  ///
  final engagement = const _GsaServiceTrackingEventEngagement();

  /// Methods used for logging of cart events.
  ///
  final cart = const _GsaServiceTrackingEventCart();
}
