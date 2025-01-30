/// Globally-accessible application services,
/// such as cache management, user authentication, input validation, etc.
///
/// All of the service class instances are implemented as subclasses of the [GsaService] object.

library services;

export 'src/app_tracking_transparency/service_app_tracking_transparency.dart';
export 'src/auth/service_auth.dart';
export 'src/bookmarks/service_bookmarks.dart';
export 'src/cache/service_cache.dart';
export 'src/consent/service_consent.dart';
export 'src/location/service_location.dart';
export 'src/logging/service_logging.dart';
export 'src/tracking/service_tracking.dart';
export 'src/url_launcher/service_url_launcher.dart';
