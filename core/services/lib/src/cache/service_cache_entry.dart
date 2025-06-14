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

  @override
  String get cacheId {
    return name;
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
      case GsaServiceCacheEntry.mandatoryCookiesConsent:
        return bool;
      case GsaServiceCacheEntry.functionalCookiesConsent:
        return bool;
      case GsaServiceCacheEntry.statisticalCookiesConsent:
        return bool;
      case GsaServiceCacheEntry.marketingCookiesConsent:
        return bool;
      case GsaServiceCacheEntry.bookmarks:
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
      case GsaServiceCacheEntry.mandatoryCookiesConsent:
        return 'Mandatory cookies';
      case GsaServiceCacheEntry.functionalCookiesConsent:
        return 'Functional cookies';
      case GsaServiceCacheEntry.statisticalCookiesConsent:
        return 'Statistical cookies';
      case GsaServiceCacheEntry.marketingCookiesConsent:
        return 'Marketing cookies';
      case GsaServiceCacheEntry.bookmarks:
        return 'Bookmarks';
    }
  }
}
