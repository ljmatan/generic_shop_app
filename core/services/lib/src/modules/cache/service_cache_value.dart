part of 'service_cache.dart';

/// A base class defining methods and properties for the cache value service.
///
abstract mixin class GsaServiceCacheValue {
  /// Unique identifier representing a cache value.
  ///
  String get cacheId;

  /// Certain cache values don't need to be prefixed with the [GsaServiceCache.instance.cacheIdPrefix].
  ///
  /// These values are marked with below getter method.
  ///
  bool get noCacheIdPrefix {
    return false;
  }

  /// Unique cache value identifier, derived from [cacheId] and [cacheIdPrefix].
  ///
  String get _cacheId {
    if (noCacheIdPrefix || GsaServiceCache.instance.cacheIdPrefix == null) {
      return cacheId;
    } else {
      return '${GsaServiceCache.instance.cacheIdPrefix}-$cacheId';
    }
  }

  /// The specified data type for this cache value.
  ///
  Type get dataType;

  /// Whether this cache entry is defined as a functional cookie.
  ///
  bool get isFunctionalCookie;

  /// Method checking for the functional cookie permission type and status.
  ///
  bool get _isFunctionalCookieEnabled {
    return !isFunctionalCookie || GsaServiceConsent.instance.consentStatus.functionalCookies() == true;
  }

  /// A default value assigned to this cache item on initial app setup.
  ///
  dynamic get defaultValue {
    return null;
  }

  /// Whether the value is enabled for retrieval.
  ///
  bool get isEnabled {
    return true;
  }

  /// Whether the value should be encrypted before being recorded to the device storage.
  ///
  bool get isSecure {
    return false;
  }

  /// Retrieves the cached data (if exists) according to the specified [dataType].
  ///
  dynamic get value {
    if (!isEnabled || !_isFunctionalCookieEnabled) {
      return null;
    }
    try {
      switch (dataType) {
        case const (int):
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            final value = GsaServiceCache.instance._getDbStorageValue(_cacheId);
            if (value?.isNotEmpty == true) {
              return int.tryParse(value!);
            } else {
              return defaultValue;
            }
          } else {
            final value = GsaServiceCache.instance._sharedPreferences?.getInt(_cacheId);
            return value ?? defaultValue;
          }
        case const (bool):
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            final value = GsaServiceCache.instance._getDbStorageValue(_cacheId);
            if (value?.isNotEmpty == true) {
              return bool.tryParse(value!);
            } else {
              return defaultValue;
            }
          } else {
            final value = GsaServiceCache.instance._sharedPreferences?.getBool(_cacheId);
            return value ?? defaultValue;
          }
        case const (String):
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            final value = GsaServiceCache.instance._getDbStorageValue(_cacheId);
            if (value != null) {
              return value;
            } else {
              return defaultValue;
            }
          } else {
            final value = GsaServiceCache.instance._sharedPreferences?.getString(_cacheId);
            return value ?? defaultValue;
          }
        case const (Iterable<String>):
        case const (List<String>):
        case const (Set<String>):
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            final value = GsaServiceCache.instance._getDbStorageValue(_cacheId);
            if (value?.isNotEmpty == true) {
              final decodedValue = dart_convert.jsonDecode(value!);
              return List<String>.from(decodedValue);
            } else {
              return defaultValue;
            }
          } else {
            final value = GsaServiceCache.instance._sharedPreferences?.getStringList(_cacheId);
            return value ?? defaultValue;
          }
        default:
          throw 'Value get method not implemented for $dataType with $_cacheId.';
      }
    } catch (e) {
      GsaServiceLogging.instance.logError(
        'Couldn\'t return value for $cacheId:\n$e',
      );
      rethrow;
    }
  }

  /// Retrieves the cached data (if exists) according to the specified [dataType].
  ///
  dynamic get decrypted {
    if (!isEnabled || !isSecure) return null;
    // TODO
    return value;
  }

  /// Records the given value to the device storage.
  ///
  /// The specified data type for the [value] parameter can be cross-referenced from [dataType].
  ///
  Future<void> setValue(dynamic value) async {
    if (value == null) {
      throw 'Value for $_cacheId must not be null.';
    }
    if (value.runtimeType != dataType &&
        dataType is Iterable &&
        !<Type>{
          List,
          Set,
        }.contains(dataType)) {
      throw 'Incorrect value type ${value.runtimeType} given for $_cacheId.';
    }
    if (isEnabled && _isFunctionalCookieEnabled) {
      switch (dataType) {
        case const (int):
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            final stringValue = (value as int).toString();
            await GsaServiceCache.instance._setDbStorageValue(
              cacheId: _cacheId,
              value: stringValue,
            );
          } else {
            await GsaServiceCache.instance._sharedPreferences?.setInt(_cacheId, value);
          }
          break;
        case const (bool):
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            final stringValue = (value as bool).toString();
            await GsaServiceCache.instance._setDbStorageValue(
              cacheId: _cacheId,
              value: stringValue,
            );
          } else {
            await GsaServiceCache.instance._sharedPreferences?.setBool(_cacheId, value);
          }
          break;
        case const (String):
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            await GsaServiceCache.instance._setDbStorageValue(
              cacheId: _cacheId,
              value: value as String,
            );
          } else {
            await GsaServiceCache.instance._sharedPreferences?.setString(_cacheId, value);
          }
          break;
        case const (Iterable<String>):
        case const (List<String>):
        case const (Set<String>):
          print('e');
          final listValue = (value as Iterable<String>).toList();
          print('d');
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            final encodedValue = dart_convert.jsonEncode(listValue);
            await GsaServiceCache.instance._setDbStorageValue(
              cacheId: _cacheId,
              value: encodedValue,
            );
          } else {
            await GsaServiceCache.instance._sharedPreferences?.setStringList(_cacheId, listValue);
          }
          break;
        default:
          throw 'Value set method not implemented for $dataType with $this.';
      }
    }
  }

  /// Removes the given value for this instance from the given storage.
  ///
  Future<void> removeValue() async {
    if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
      await GsaServiceCache.instance._removeDbStorageValue(_cacheId);
    } else {
      await GsaServiceCache.instance._sharedPreferences?.remove(_cacheId);
    }
  }

  /// User-visible name for this cache data instance.
  ///
  String get displayName;
}
