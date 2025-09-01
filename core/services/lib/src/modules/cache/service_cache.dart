import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_services/services.dart';
import 'package:shared_preferences/shared_preferences.dart' as shared_preferences;
import 'package:sembast/sembast.dart' as sembast;
import 'package:sembast_web/sembast_web.dart' as sembast_web;
import 'package:sembast/sembast_io.dart' as sembast_io;
import 'package:sembast/utils/database_utils.dart' as sembast_utils;

part '../../i18n/service_cache_i18n.dart';
part 'service_cache_entry.dart';
part 'service_cache_value.dart';

/// Cache data manager, implemented with the
/// [shared_preferences](https://pub.dev/packages/shared_preferences) package.
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

  /// Whether the implementation is relying on
  /// [sembast_web](https://pub.dev/packages/sembast_web)
  /// as opposed to the [https://pub.dev/packages/shared_preferences] package.
  ///
  /// The shared_preferences implementation might run into
  /// [QuotaExceededError](https://developer.mozilla.org/en-US/docs/Web/API/QuotaExceededError),
  /// which is why a database integration is preferred.
  ///
  bool database = kIsWeb || kIsWasm;

  /// Entrypoint to the methods and properties provided by the shared_preferences package.
  ///
  shared_preferences.SharedPreferencesWithCache? _sharedPreferences;

  /// A class to manage database storage for cache services.
  ///
  sembast.Database? _db;

  /// A pointer to a database store.
  ///
  sembast.StoreRef? _dbStorage;

  /// Runtime collection of values retrieved from the secure storage.
  ///
  Map<int, String>? _dbStorageEntries;

  /// Initialises the [_sharedPreferences] property and handle data cache versions.
  ///
  /// The method must be manually invoked at app startup,
  /// as [GsaData] and [GsaService] implementations rely on the cache service.
  ///
  @override
  Future<void> init() async {
    await super.init();
    const timeoutDuration = Duration(seconds: 10);
    const timeoutMessage = 'Failed to initialise cache service within alloted timeframe.';
    if (database) {
      _dbStorage = sembast.intMapStoreFactory.store();
      _db = await sembast_web.databaseFactoryWeb.openDatabase('gsaCache').timeout(
        timeoutDuration,
        onTimeout: () {
          throw Exception(timeoutMessage);
        },
      );
      final entries = await _dbStorage!.find(_db!);
      _dbStorageEntries = {};
      for (final entry in entries) {
        if (entry.key != null && entry.value != null) {
          _dbStorageEntries![entry.key as int] = entry.value!.toString();
        }
      }
    } else {
      _sharedPreferences = await shared_preferences.SharedPreferencesWithCache.create(
        cacheOptions: shared_preferences.SharedPreferencesWithCacheOptions(),
      ).timeout(
        timeoutDuration,
        onTimeout: () {
          throw Exception(timeoutMessage);
        },
      );
    }
  }

  /// Collection of cache value entries specified for the app instance.
  ///
  /// May be edited during the runtime to ensure correct data propagation and handling.
  ///
  final _cacheEntries = <GsaServiceCacheValue>[
    ...GsaServiceCacheEntry.values,
  ];

  /// Registers client cache entries for cookie value adjustment.
  ///
  void registerCacheEntries(
    List<GsaServiceCacheValue> values,
  ) {
    _cacheEntries.addAll(values);
  }

  /// Event triggered on user cookie acknowledgement.
  ///
  Future<void> onCookieConsentAcknowledged() async {
    final version = GsaServiceCacheEntry.version.value as int?;
    // If the cached version is different than the current [_version], handle logic for updating cached values.
    if (_version != version) {
      if (version == null) {
        /// If the cached [version] argument is `null`, the user hasn't previously acknowledged cache service consent.
        ///
        /// Once the user has given their consent, default values defined for [GsaServiceCacheEntry] objects are recorded to device storage.
        ///
        for (final cacheId in GsaServiceCacheEntry.values) {
          if (cacheId.defaultValue != null) {
            try {
              cacheId.setValue(cacheId.defaultValue);
            } catch (e) {
              GsaServiceLogging.instance.logError('Error setting default cache value: $e');
            }
          }
        }
      } else {
        switch (version) {
          /// Here we can add logic for handling cached values if is a newer version of cache manager
          /// for every new version add a new case
          case _version:
            // Version is up-to-date.
            break;
          default:
            throw '${GsaServiceCacheI18N.invalidVersionErrorMessage.value.display}: $version';
        }
      }
    }
    // Clear cookies according to user consent status.
    for (final cacheEntry in _cacheEntries) {
      if (cacheEntry.isFunctionalCookie && !GsaServiceConsent.instance.consentStatus.functionalCookies()) {
        await cacheEntry.removeValue();
      }
    }
  }

  /// Persistent cache data; shouldn't be deleted.
  ///
  final persistent = <GsaServiceCacheEntry>{
    GsaServiceCacheEntry.version,
    GsaServiceCacheEntry.cookieConsentMandatory,
    GsaServiceCacheEntry.cookieConsentFunctional,
    GsaServiceCacheEntry.cookieConsentMarketing,
    GsaServiceCacheEntry.cookieConsentStatistical,
  };

  /// Collection of cached value keys stored to the user device.
  ///
  Set<String>? get cachedKeys {
    if (database) {
      return _dbStorageEntries?.keys.map(
        (intKey) {
          return intKey.toString();
        },
      ).toSet();
    } else {
      return _sharedPreferences?.keys;
    }
  }

  /// Removes all cache data from the device storage,
  /// except for the keys noted under the [persistent] list.
  ///
  Future<void> clearData({
    bool clearPersistent = false,
  }) async {
    for (var key in cachedKeys ?? <String>[]) {
      if (clearPersistent ||
          persistent
              .where(
                (cacheId) => cacheId.name == key,
              )
              .isEmpty) {
        if (database) {
          if (_db != null && int.tryParse(key) != null) {
            await _dbStorage
                ?.record(
                  int.parse(key),
                )
                .delete(_db!);
          }
        } else {
          await _sharedPreferences?.remove(key);
        }
      }
    }
  }

  /// Returns a value associated with the specified [key].
  ///
  dynamic valueWithKey(String key) {
    if (database) {
      // TODO?
      return null;
    } else {
      return _sharedPreferences?.get(key);
    }
  }
}
