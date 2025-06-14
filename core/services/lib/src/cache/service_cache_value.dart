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

  /// A default value assigned to this cache item on initial app setup.
  ///
  dynamic get defaultValue {
    return null;
  }

  /// Whether the value is enabled for retrieval.
  ///
  bool get enabled {
    return true;
  }

  /// Whether the value should be encrypted before being recorded to the device storage.
  ///
  bool get secure {
    return false;
  }

  /// Retrieves the cached data (if exists) according to the specified [dataType].
  ///
  dynamic get value {
    if (!enabled) return null;
    switch (dataType) {
      case const (int):
        return GsaServiceCache.instance._sharedPreferences?.getInt(cacheId);
      case const (bool):
        return GsaServiceCache.instance._sharedPreferences?.getBool(cacheId);
      case const (String):
        return GsaServiceCache.instance._sharedPreferences?.getString(cacheId);
      case const (Iterable<String>):
      case const (List<String>):
      case const (Set<String>):
        return GsaServiceCache.instance._sharedPreferences?.getStringList(cacheId);
      default:
        throw 'Value get method not implemented for $dataType with $this.';
    }
  }

  /// Retrieves the cached data (if exists) according to the specified [dataType].
  ///
  dynamic get decrypted {
    if (!enabled || !secure) return null;
    switch (dataType) {
      case const (int):
        return GsaServiceCache.instance._sharedPreferences?.getInt(cacheId);
      case const (bool):
        return GsaServiceCache.instance._sharedPreferences?.getBool(cacheId);
      case const (String):
        return GsaServiceCache.instance._sharedPreferences?.getString(cacheId);
      case const (Iterable<String>):
      case const (List<String>):
      case const (Set<String>):
        return GsaServiceCache.instance._sharedPreferences?.getStringList(cacheId);
      default:
        throw 'Value get method not implemented for $dataType with $this.';
    }
  }

  /// Records the given value to the device storage.
  ///
  /// The specified data type for the [value] parameter can be cross-referenced from [dataType].
  ///
  Future<void> setValue(dynamic value) async {
    if (value == null) {
      throw 'Value for $this must not be null.';
    }
    if (value.runtimeType != dataType) {
      throw 'Incorrect value type ${value.runtimeType} given for $this.';
    }
    if (enabled) {
      switch (dataType) {
        case const (int):
          await GsaServiceCache.instance._sharedPreferences?.setInt(cacheId, value);
          break;
        case const (bool):
          await GsaServiceCache.instance._sharedPreferences?.setBool(cacheId, value);
          break;
        case const (String):
          await GsaServiceCache.instance._sharedPreferences?.setString(cacheId, value);
          break;
        case const (Iterable<String>):
        case const (List<String>):
        case const (Set<String>):
          await GsaServiceCache.instance._sharedPreferences?.setStringList(cacheId, value);
          break;
        default:
          throw 'Value set method not implemented for $dataType with $this.';
      }
    }
  }

  /// Removes the given value for this instance from the given storage.
  ///
  Future<void> removeValue() async {
    await GsaServiceCache.instance._sharedPreferences?.remove(cacheId);
  }

  /// User-visible name for this cache data instance.
  ///
  String get displayName;
}
