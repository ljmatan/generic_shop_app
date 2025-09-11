/// Globally-accessible application services,
/// such as cache management, user authentication, input validation, etc.
///
/// All of the service class instances are implemented as subclasses of the [GsaService] object.

library;

export 'src/modules/app_tracking_transparency/service_app_tracking_transparency.dart';
export 'src/modules/auth/service_auth.dart';
export 'src/modules/bookmarks/service_bookmarks.dart';
export 'src/modules/cache/service_cache.dart';
export 'src/modules/calendar/service_calendar.dart';
export 'src/modules/clipboard/service_clipboard.dart';
export 'src/modules/compress/service_compress.dart';
export 'src/modules/consent/service_consent.dart';
export 'src/modules/debug/service_debug.dart';
export 'src/modules/device_info/service_device_info.dart';
export 'src/modules/encryption/service_encryption.dart';
export 'src/modules/i18n/service_i18n.dart';
export 'src/modules/input_validation/service_input_validation.dart';
export 'src/modules/location/service_location.dart';
export 'src/modules/logging/service_logging.dart';
export 'src/modules/permissions/service_permissions.dart';
export 'src/modules/share/service_share.dart';
export 'src/modules/ssl_override/service_ssl_override.dart';
export 'src/modules/search/service_search.dart';
export 'src/modules/tracking/service_tracking.dart';
export 'src/modules/url_launcher/service_url_launcher.dart';
