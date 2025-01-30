/// Globally-accessible application services,
/// such as cache management, user authentication, input validation, etc.
///
/// All of the service class instances are implemented as subclasses of the [GsaService] object.

library services;

import 'package:generic_shop_app/services/src/app_tracking_transparency/service_app_tracking_transparency.dart';
import 'package:generic_shop_app/services/src/auth/service_auth.dart';
import 'package:generic_shop_app/services/src/bookmarks/service_bookmarks.dart';
import 'package:generic_shop_app/services/src/cache/service_cache.dart';
import 'package:generic_shop_app/services/src/consent/service_consent.dart';
import 'package:generic_shop_app/services/src/location/service_location.dart';
import 'package:generic_shop_app/services/src/logging/service_logging.dart';
import 'package:generic_shop_app/services/src/tracking/service_tracking.dart';
import 'package:generic_shop_app/services/src/url_launcher/service_url_launcher.dart';

export 'src/app_tracking_transparency/service_app_tracking_transparency.dart';
export 'src/auth/service_auth.dart';
export 'src/bookmarks/service_bookmarks.dart';
export 'src/cache/service_cache.dart';
export 'src/consent/service_consent.dart';
export 'src/location/service_location.dart';
export 'src/logging/service_logging.dart';
export 'src/tracking/service_tracking.dart';
export 'src/url_launcher/service_url_launcher.dart';

/// Below declaration is required to ensure object memory allocation.
///
// ignore: unused_element
final _instances = [
  GsaServiceAppTrackingTransparency.instance,
  GsaServiceAuth.instance,
  GsaServiceBookmarks.instance,
  GsaServiceCache.instance,
  GsaServiceConsent.instance,
  GsaServiceLocation.instance,
  GsaServiceLogging.instance,
  GsaServiceTracking.instance,
  GsaServiceUrlLauncher.instance,
];
