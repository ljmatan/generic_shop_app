// ignore_for_file: library_private_types_in_public_api

part of 'service_cache.dart';

/// A base class defining methods and properties for the cache value service.
///
abstract mixin class GsaServiceCacheValue {
  /// Unique identifier representing a cache value.
  ///
  String get cacheId;

  /// The specified data type for this cache value.
  ///
  Type get dataType;

  /// Whether the value should be encrypted before being recorded to the device storage.
  ///
  bool get isSecure {
    return false;
  }

  /// User-visible name for this cache data instance.
  ///
  String get displayName;

  /// Type of cookie declared with this cache entry.
  ///
  /// Cookies can be used for either of below [mandatory], [functionality], [statistics], or [marketing] purposes.
  ///
  /// To ensure appropriate cookie categorisation, these values are specified for each cookie or cache value entry.
  ///
  ({
    bool mandatory,
    bool functionality,
    bool statistics,
    bool marketing,
  }) get cookieType;

  /// Mandatory cookie value representation.
  ///
  _GsaServiceCacheValue get mandatoryCookie {
    if (cookieType.mandatory != true) {
      throw Exception(
        'Mandatory cookie type not supported for $cacheId',
      );
    }
    return _GsaServiceCacheValue(
      isMandatoryCookieType: true,
      id: cacheId,
      type: dataType,
      name: displayName,
    );
  }

  /// Functionality cookie value representation.
  ///
  _GsaServiceCacheValue get functionalityCookie {
    if (cookieType.functionality != true) {
      throw Exception(
        'Functionality cookie type not supported for $cacheId',
      );
    }
    return _GsaServiceCacheValue(
      isFunctionalityCookieType: true,
      id: cacheId,
      type: dataType,
      name: displayName,
    );
  }

  /// Statistics cookie value representation.
  ///
  _GsaServiceCacheValue get statisticsCookie {
    if (cookieType.statistics != true) {
      throw Exception(
        'Statistics cookie type not supported for $cacheId',
      );
    }
    return _GsaServiceCacheValue(
      isStatisticsCookieType: true,
      id: cacheId,
      type: dataType,
      name: displayName,
    );
  }

  /// Marketing cookie value representation.
  ///
  _GsaServiceCacheValue get marketingCookie {
    if (cookieType.marketing != true) {
      throw Exception(
        'Marketing cookie type not supported for $cacheId',
      );
    }
    return _GsaServiceCacheValue(
      isMarketingCookieType: true,
      id: cacheId,
      type: dataType,
      name: displayName,
    );
  }
}

/// Value representing a cache entry.
///
/// The class is instantiated by the mixin class for all 4 possible cookie categories.
///
/// Cookie handling is defined with this class, while the superclass is used for enum integration.
///
class _GsaServiceCacheValue with GsaServiceCacheValue {
  const _GsaServiceCacheValue({
    this.isMandatoryCookieType = false,
    this.isFunctionalityCookieType = false,
    this.isStatisticsCookieType = false,
    this.isMarketingCookieType = false,
    required this.id,
    required this.type,
    required this.name,
  });

  /// Cookie value type, defining the processing logic.
  ///
  final bool isMandatoryCookieType, isFunctionalityCookieType, isStatisticsCookieType, isMarketingCookieType;

  /// Unique identifier assigned to this value, defined with [cacheId] in mixin class.
  ///
  final String id;

  /// Data type of the cookie value, defined with [dataType] in mixin class.
  ///
  final Type type;

  /// User-visible cookie identifier, defined with [displayName] in mixin class.
  ///
  final String name;

  @override
  String get cacheId {
    return id;
  }

  /// Unique cache value identifier, derived from [cacheId] and [cacheIdPrefix].
  ///
  String get _cacheId {
    String id = '';
    if (GsaServiceCache.instance._cacheIdPrefix != null) {
      id += '${GsaServiceCache.instance._cacheIdPrefix}-';
    }
    if (isMandatoryCookieType) {
      id += 'mandatory-';
    }
    if (isFunctionalityCookieType) {
      id += 'functionality-';
    }
    if (isStatisticsCookieType) {
      id += 'statistics-';
    }
    if (isMarketingCookieType) {
      id += 'marketing-';
    }
    id += cacheId;
    return id;
  }

  @override
  Type get dataType {
    return type;
  }

  @override
  String get displayName {
    return name;
  }

  @override
  ({
    bool mandatory,
    bool functionality,
    bool statistics,
    bool marketing,
  }) get cookieType {
    return (
      mandatory: isMandatoryCookieType,
      functionality: isFunctionalityCookieType,
      statistics: isStatisticsCookieType,
      marketing: isMarketingCookieType,
    );
  }

  bool get isEnabled {
    final functionalityValueInaccessible =
        isFunctionalityCookieType && GsaServiceConsent.instance.consentStatus.functionalityCookies() != true;
    final statisticsValueInaccessible = isStatisticsCookieType && GsaServiceConsent.instance.consentStatus.statisticsCookies() != true;
    final marketingValueInaccessible = isMarketingCookieType && GsaServiceConsent.instance.consentStatus.marketingCookies() != true;
    return !functionalityValueInaccessible && !statisticsValueInaccessible && !marketingValueInaccessible;
  }

  /// Retrieves the cached data (if exists) according to the specified [dataType].
  ///
  dynamic get value {
    if (!isEnabled) {
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
              return null;
            }
          } else {
            return GsaServiceCache.instance._sharedPreferences?.getInt(_cacheId);
          }
        case const (bool):
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            final value = GsaServiceCache.instance._getDbStorageValue(_cacheId);
            if (value?.isNotEmpty == true) {
              return bool.tryParse(value!);
            } else {
              return null;
            }
          } else {
            return GsaServiceCache.instance._sharedPreferences?.getBool(_cacheId);
          }
        case const (String):
          if (GsaServiceCache.instance.database && GsaServiceCache.instance._db != null) {
            final value = GsaServiceCache.instance._getDbStorageValue(_cacheId);
            if (value != null) {
              return value;
            } else {
              return null;
            }
          } else {
            return GsaServiceCache.instance._sharedPreferences?.getString(_cacheId);
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
              return null;
            }
          } else {
            return GsaServiceCache.instance._sharedPreferences?.getStringList(_cacheId);
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
    if (isEnabled) {
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
          final listValue = (value as Iterable<String>).toList();
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
}
