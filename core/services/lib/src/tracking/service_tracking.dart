import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_architecture/arch.dart';

part 'models/service_tracking_model_event.dart';
part 'events/service_tracking_event_cart.dart';
part 'events/service_tracking_event_engagement.dart';
part 'events/service_tracking_event_route.dart';

/// User activity tracking service.
///
class GsaServiceTracking extends GsaService {
  GsaServiceTracking._();

  static final _instance = GsaServiceTracking._();

  /// Globally-accessible singleton class instance.
  ///
  static GsaServiceTracking get instance => _instance() as GsaServiceTracking;

  /// Records a log entry to the local device storage.
  ///
  /// The method will only run if the user consent has been given.
  ///
  Future<void> _logEvent(
    GsaServiceTrackingModelEvent log,
  ) async {
    final statisticalCookieConsentAccepted = GsaServiceConsent.instance.consentStatus.statisticsCookies() == true;
    final marketingCookieConsentAccepted = !log.marketing || GsaServiceConsent.instance.consentStatus.marketingCookies() == true;
    if (statisticalCookieConsentAccepted && marketingCookieConsentAccepted) {
      await executeAsync(
        () async {},
      );
    }
  }

  /// Methods used for logging of user engagement events.
  ///
  final engagement = const _GsaServiceTrackingEventEngagement._();

  /// Methods used for logging of cart events.
  ///
  final cart = const _GsaServiceTrackingEventCart._();

  /// Methods used for logging of navigation events.
  ///
  final route = const _GsaServiceTrackingEventRoute._();
}
