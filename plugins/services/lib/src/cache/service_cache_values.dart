part of 'service_cache.dart';

/// Identifiers (keys) for cached values.
///
enum GsaServiceCacheId {
  /// Cache manager version, used for migration purposes.
  ///
  /// Version will be null with a freshly-installed app.
  /// With app updates, the [GsaServiceCache] version can also be updated, which can then be referenced against this value.
  ///
  version,

  /// Token used to authenticate the user with the backend.
  ///
  /// https://en.wikipedia.org/wiki/JSON_Web_Token
  ///
  authenticationToken,

  /// JSON-encoded string representing the cached guest user information.
  ///
  guestUserEncodedData,

  /// Status of the mandatory cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  mandatoryCookiesConsent,

  /// Status of the functional cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  functionalCookiesConsent,

  /// Status of the statistical cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  statisticalCookiesConsent,

  /// Status of the marketing cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  marketingCookiesConsent,

  /// Bookmarked sale item identifiers.
  ///
  bookmarks;

  /// The specified data type for this cache value.
  ///
  Type get dataType {
    switch (this) {
      case GsaServiceCacheId.version:
        return int;
      case GsaServiceCacheId.authenticationToken:
        return String;
      case GsaServiceCacheId.guestUserEncodedData:
        return String;
      case GsaServiceCacheId.mandatoryCookiesConsent:
        return bool;
      case GsaServiceCacheId.functionalCookiesConsent:
        return bool;
      case GsaServiceCacheId.statisticalCookiesConsent:
        return bool;
      case GsaServiceCacheId.marketingCookiesConsent:
        return bool;
      case GsaServiceCacheId.bookmarks:
        return List<String>;
    }
  }

  /// A default value assigned to this cache item on initial app setup.
  ///
  dynamic get defaultValue {
    switch (this) {
      case GsaServiceCacheId.version:
        return GsaServiceCache._version;
      default:
        return null;
    }
  }

  /// Whether the value is enabled for retrieval.
  ///
  bool get enabled {
    switch (this) {
      default:
        return true;
    }
  }

  /// Whether the value should be encrypted before being recorded to the device storage.
  ///
  bool get secure {
    switch (this) {
      case GsaServiceCacheId.authenticationToken:
        return true;
      case GsaServiceCacheId.guestUserEncodedData:
        return true;
      default:
        return false;
    }
  }

  /// Retrieves the cached data (if exists) according to the specified [dataType].
  ///
  dynamic get value {
    if (!enabled) return null;
    switch (dataType) {
      case const (int):
        return GsaServiceCache.instance._sharedPreferences?.getInt(name);
      case const (bool):
        return GsaServiceCache.instance._sharedPreferences?.getBool(name);
      case const (String):
        return GsaServiceCache.instance._sharedPreferences?.getString(name);
      case const (List<String>):
        return GsaServiceCache.instance._sharedPreferences?.getStringList(name);
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
        return GsaServiceCache.instance._sharedPreferences?.getInt(name);
      case const (bool):
        return GsaServiceCache.instance._sharedPreferences?.getBool(name);
      case const (String):
        return GsaServiceCache.instance._sharedPreferences?.getString(name);
      case const (List<String>):
        return GsaServiceCache.instance._sharedPreferences?.getStringList(name);
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
          await GsaServiceCache.instance._sharedPreferences?.setInt(name, value);
          break;
        case const (bool):
          await GsaServiceCache.instance._sharedPreferences?.setBool(name, value);
          break;
        case const (String):
          await GsaServiceCache.instance._sharedPreferences?.setString(name, value);
          break;
        case const (List<String>):
          await GsaServiceCache.instance._sharedPreferences?.setStringList(name, value);
          break;
        default:
          throw 'Value set method not implemented for $dataType with $this.';
      }
    }
  }

  /// Removes the given value for this instance from the given storage.
  ///
  Future<void> removeValue() async {
    await GsaServiceCache.instance._sharedPreferences?.remove(name);
  }

  /// User-visible name for this cache data instance.
  ///
  String get displayName {
    switch (this) {
      case GsaServiceCacheId.version:
        return 'Version';
      case GsaServiceCacheId.authenticationToken:
        return 'Authentication Token';
      case GsaServiceCacheId.guestUserEncodedData:
        return 'Guest User Encoded Data';
      case GsaServiceCacheId.mandatoryCookiesConsent:
        return 'Mandatory cookies';
      case GsaServiceCacheId.functionalCookiesConsent:
        return 'Functional cookies';
      case GsaServiceCacheId.statisticalCookiesConsent:
        return 'Statistical cookies';
      case GsaServiceCacheId.marketingCookiesConsent:
        return 'Marketing cookies';
      case GsaServiceCacheId.bookmarks:
        return 'Bookmarks';
    }
  }
}
