part of 'service_cache.dart';

/// Identifiers (keys) for cached values.
///
enum GsaServiceCacheEntry with GsaServiceCacheValue {
  /// Cache manager version, used for migration purposes.
  ///
  /// Version will be null with a freshly-installed app.
  /// With app updates, the [GsaServiceCache] version can also be updated, which can then be referenced against this value.
  ///
  version,

  /// Status of the mandatory cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  cookieConsentMandatory,

  /// Status of the functional cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  cookieConsentFunctional,

  /// Status of the statistical cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  cookieConsentStatistical,

  /// Status of the marketing cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  cookieConsentMarketing,

  /// Token used to authenticate the user with the backend.
  ///
  /// https://en.wikipedia.org/wiki/JSON_Web_Token
  ///
  authenticationToken,

  /// JSON-encoded string representing the cached guest user information.
  ///
  guestUserEncodedData,

  /// Bookmarked sale item identifiers.
  ///
  bookmarks,

  /// Collection of search terms recorded to the device memory.
  ///
  shopSearchHistory;

  @override
  String get cacheId {
    return name;
  }

  @override
  String? get cacheIdPrefix {
    return null;
  }

  @override
  Type get dataType {
    switch (this) {
      case GsaServiceCacheEntry.version:
        return int;
      case GsaServiceCacheEntry.authenticationToken:
        return String;
      case GsaServiceCacheEntry.guestUserEncodedData:
        return String;
      case GsaServiceCacheEntry.cookieConsentMandatory:
        return bool;
      case GsaServiceCacheEntry.cookieConsentFunctional:
        return bool;
      case GsaServiceCacheEntry.cookieConsentStatistical:
        return bool;
      case GsaServiceCacheEntry.cookieConsentMarketing:
        return bool;
      case GsaServiceCacheEntry.bookmarks:
        return List<String>;
      case GsaServiceCacheEntry.shopSearchHistory:
        return List<String>;
    }
  }

  @override
  get defaultValue {
    switch (this) {
      case GsaServiceCacheEntry.version:
        return GsaServiceCache._version;
      default:
        return null;
    }
  }

  @override
  bool get secure {
    switch (this) {
      case GsaServiceCacheEntry.authenticationToken:
        return true;
      case GsaServiceCacheEntry.guestUserEncodedData:
        return true;
      default:
        return false;
    }
  }

  @override
  String get displayName {
    switch (this) {
      case GsaServiceCacheEntry.version:
        return 'Version';
      case GsaServiceCacheEntry.authenticationToken:
        return 'Authentication Token';
      case GsaServiceCacheEntry.guestUserEncodedData:
        return 'Guest User Encoded Data';
      case GsaServiceCacheEntry.cookieConsentMandatory:
        return 'Mandatory Cookies';
      case GsaServiceCacheEntry.cookieConsentFunctional:
        return 'Functional Cookies';
      case GsaServiceCacheEntry.cookieConsentStatistical:
        return 'Statistical Cookies';
      case GsaServiceCacheEntry.cookieConsentMarketing:
        return 'Marketing Cookies';
      case GsaServiceCacheEntry.bookmarks:
        return 'Bookmarks';
      case GsaServiceCacheEntry.shopSearchHistory:
        return 'Shop Search History';
    }
  }
}
