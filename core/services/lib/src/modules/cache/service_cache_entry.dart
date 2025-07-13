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

  /// Collection of translations loaded into the app and updated with any relevant changes.
  ///
  /// Only used when [GsaConfig.editMode] is set to `true`.
  ///
  translations,

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
  shopSearchHistory,

  /// User-specified app theme brightness.
  ///
  themeBrightness;

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
      case GsaServiceCacheEntry.translations:
        return Iterable<String>;
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
        return Iterable<String>;
      case GsaServiceCacheEntry.shopSearchHistory:
        return Iterable<String>;
      case GsaServiceCacheEntry.themeBrightness:
        return String;
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
        return GsaServiceCacheI18N.version.value.display;
      case GsaServiceCacheEntry.translations:
        return GsaServiceCacheI18N.translations.value.display;
      case GsaServiceCacheEntry.authenticationToken:
        return GsaServiceCacheI18N.authenticationToken.value.display;
      case GsaServiceCacheEntry.guestUserEncodedData:
        return GsaServiceCacheI18N.guestUserEncodedData.value.display;
      case GsaServiceCacheEntry.cookieConsentMandatory:
        return GsaServiceCacheI18N.cookieConsentMandatory.value.display;
      case GsaServiceCacheEntry.cookieConsentFunctional:
        return GsaServiceCacheI18N.cookieConsentFunctional.value.display;
      case GsaServiceCacheEntry.cookieConsentStatistical:
        return GsaServiceCacheI18N.cookieConsentStatistical.value.display;
      case GsaServiceCacheEntry.cookieConsentMarketing:
        return GsaServiceCacheI18N.cookieConsentMarketing.value.display;
      case GsaServiceCacheEntry.bookmarks:
        return GsaServiceCacheI18N.bookmarks.value.display;
      case GsaServiceCacheEntry.shopSearchHistory:
        return GsaServiceCacheI18N.shopSearchHistory.value.display;
      case GsaServiceCacheEntry.themeBrightness:
        return GsaServiceCacheI18N.themeBrightness.value.display;
    }
  }
}
