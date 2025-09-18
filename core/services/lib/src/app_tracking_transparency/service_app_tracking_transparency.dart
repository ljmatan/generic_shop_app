import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart' as att;
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';

/// The AppTrackingTransparency framework presents an app-tracking authorization request to the user
/// and provides the tracking authorization status.
///
/// AppTrackingTransparency framework must be used if an app collects data about end users
/// and shares it with other companies for purposes of tracking across apps and web sites.
///
/// https://developer.apple.com/documentation/apptrackingtransparency
///
class GsaServiceAppTrackingTransparency extends GsaService {
  GsaServiceAppTrackingTransparency._();

  static final _instance = GsaServiceAppTrackingTransparency._();

  /// Globally-accessible class instance.
  ///
  static GsaServiceAppTrackingTransparency get instance => _instance() as GsaServiceAppTrackingTransparency;

  /// Whether the app tracking transparency consent is given by the user.
  ///
  late bool consentGiven;

  /// Request App Tracking Transparency user consent via system dialog.
  ///
  Future<bool> requestConsent() async {
    final responseStatus = await att.AppTrackingTransparency.requestTrackingAuthorization();
    consentGiven = responseStatus == att.TrackingStatus.authorized;
    return consentGiven;
  }

  @override
  Future<void> init(BuildContext context) async {
    await super.init(context);
    consentGiven =
        kIsWeb || Platform.isAndroid || await att.AppTrackingTransparency.trackingAuthorizationStatus == att.TrackingStatus.authorized;
  }
}
