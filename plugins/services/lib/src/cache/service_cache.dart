import '../../services.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:shared_preferences/shared_preferences.dart' as shared_preferences;

part 'service_cache_values.dart';

/// Cache data manager, implemented with the [shared_preferences](https://pub.dev/packages/shared_preferences) package.
///
class GsaServiceCache extends GsaService {
  GsaServiceCache._();

  static final _instance = GsaServiceCache._();

  /// Globally-accesible class instance.
  ///
  static GsaServiceCache get instance => _instance() as GsaServiceCache;

  @override
  bool get critical => true;

  @override
  bool get manualInit => true;

  /// Cache manager version specifier.
  ///
  /// Updating this value will invoke the migration process on the app startup.
  ///
  static const int _version = 0;

  /// Entrypoint to the methods and properties provided by the shared_preferences package.
  ///
  shared_preferences.SharedPreferences? _sharedPreferences;

  /// Initialises the [_sharedPreferences] property and handle data cache versions.
  ///
  /// The method must be manually invoked at app startup,
  /// as [GsaData] and [GsaService] implementations rely on the cache service.
  ///
  @override
  Future<void> init() async {
    await super.init();
    shared_preferences.SharedPreferences.setPrefix('gsa');
    _sharedPreferences = await shared_preferences.SharedPreferences.getInstance();
  }

  /// Event triggered on user cookie acknowledgement.
  ///
  Future<void> onCookieConsentAcknowledged() async {
    final version = GsaServiceCacheId.version.value as int?;
    // If the cached version is different than the current [_version], handle logic for updating cached values.
    if (_version != version) {
      switch (version) {
        /// If the cached [version] argument is `null`, the user hasn't previously acknowledged cache service consent.
        ///
        /// Once the user has given their consent, default values defined for [GsaServiceCacheId] objects are recorded to device storage.
        ///
        case null:
          for (final cacheId in GsaServiceCacheId.values) {
            if (cacheId.defaultValue != null) {
              try {
                cacheId.setValue(cacheId.defaultValue);
              } catch (e) {
                GsaServiceLogging.logError('Error setting default cache value: $e');
              }
            }
          }

        /// Here we can add logic for handling cached values if is a newer version of cache manager
        /// for every new version add a new case
        case _version:
          // Version is up-to-date.
          break;
        default:
          throw 'Invalid cache manager version: $version';
      }
    }
  }

  /// Persistent cache data; shouldn't be deleted.
  ///
  Set<GsaServiceCacheId> persistent = {GsaServiceCacheId.version};

  /// Removes all cache data from the device storage,
  /// except for the keys noted under the [persistent] list.
  ///
  Future<void> clearData() async {
    if (_sharedPreferences != null) {
      for (var key in _sharedPreferences!.getKeys()) {
        if (persistent.where((cacheId) => cacheId.name == key).isEmpty) await _sharedPreferences?.remove(key);
      }
    }
  }
}
