part of 'service_cache.dart';

/// Identifiers (keys) for cached values.
///
enum GsaServiceCacheEntry with GsaServiceCacheValue {
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
  cookieConsentFunctionality,

  /// Status of the statistical cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  cookieConsentStatistics,

  /// Status of the marketing cookies user privacy consent.
  ///
  /// The status will be `null` if the user has not responded to the consent confirmation request,
  /// and should be `true` or `false` if the user has responded to the consent, to reflect the consent status.
  ///
  cookieConsentMarketing,

  /// Cache manager version, used for migration purposes.
  ///
  /// Version will be null with a freshly-installed app.
  /// With app updates, the [GsaServiceCache] version can also be updated, which can then be referenced against this value.
  ///
  version,

  /// A unique identifier generated on and assigned to a user device.
  ///
  /// The value is marked as mandatory in order to ensure app security when communicating with the backend services,
  /// however, it may also be used for functional, statistics, and marketing purposes,
  /// which is why the user consent must be checked before accessing this value.
  ///
  deviceId,

  /// Collection of translations loaded into the app and updated with any relevant changes.
  ///
  /// Only used when [GsaConfig.editMode] is set to `true`.
  ///
  translations,

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
  themeBrightness,

  /// Time of the first app open after install in ISO8601 format.
  ///
  firstAppOpenIso8601;

  @override
  String get cacheId {
    return name;
  }

  @override
  Type get dataType {
    switch (this) {
      case GsaServiceCacheEntry.version:
        return int;
      case GsaServiceCacheEntry.deviceId:
        return String;
      case GsaServiceCacheEntry.translations:
        return Iterable<String>;
      case GsaServiceCacheEntry.authenticationToken:
        return String;
      case GsaServiceCacheEntry.guestUserEncodedData:
        return String;
      case GsaServiceCacheEntry.cookieConsentMandatory:
        return bool;
      case GsaServiceCacheEntry.cookieConsentFunctionality:
        return bool;
      case GsaServiceCacheEntry.cookieConsentStatistics:
        return bool;
      case GsaServiceCacheEntry.cookieConsentMarketing:
        return bool;
      case GsaServiceCacheEntry.bookmarks:
        return Iterable<String>;
      case GsaServiceCacheEntry.shopSearchHistory:
        return Iterable<String>;
      case GsaServiceCacheEntry.themeBrightness:
        return String;
      case GsaServiceCacheEntry.firstAppOpenIso8601:
        return String;
    }
  }

  @override
  bool get isSecure {
    switch (this) {
      case GsaServiceCacheEntry.deviceId:
        return true;
      case GsaServiceCacheEntry.authenticationToken:
        return true;
      case GsaServiceCacheEntry.guestUserEncodedData:
        return true;
      default:
        return false;
    }
  }

  @override
  ({
    bool mandatory,
    bool functionality,
    bool statistics,
    bool marketing,
  }) get cookieType {
    return switch (this) {
      GsaServiceCacheEntry.cookieConsentMandatory => (
          mandatory: true,
          functionality: false,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.cookieConsentFunctionality => (
          mandatory: true,
          functionality: false,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.cookieConsentStatistics => (
          mandatory: true,
          functionality: false,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.cookieConsentMarketing => (
          mandatory: true,
          functionality: false,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.version => (
          mandatory: true,
          functionality: false,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.deviceId => (
          mandatory: true,
          functionality: true,
          statistics: true,
          marketing: true,
        ),
      GsaServiceCacheEntry.translations => (
          mandatory: true,
          functionality: false,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.authenticationToken => (
          mandatory: true,
          functionality: false,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.guestUserEncodedData => (
          mandatory: true,
          functionality: false,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.bookmarks => (
          mandatory: false,
          functionality: true,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.shopSearchHistory => (
          mandatory: false,
          functionality: true,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.themeBrightness => (
          mandatory: false,
          functionality: true,
          statistics: false,
          marketing: false,
        ),
      GsaServiceCacheEntry.firstAppOpenIso8601 => (
          mandatory: false,
          functionality: true,
          statistics: true,
          marketing: true,
        ),
    };
  }

  @override
  String get displayName {
    switch (this) {
      case GsaServiceCacheEntry.version:
        return GsaServiceCacheI18N._version.value.display;
      case GsaServiceCacheEntry.deviceId:
        return GsaServiceCacheI18N._deviceId.value.display;
      case GsaServiceCacheEntry.translations:
        return GsaServiceCacheI18N._translations.value.display;
      case GsaServiceCacheEntry.authenticationToken:
        return GsaServiceCacheI18N._authenticationToken.value.display;
      case GsaServiceCacheEntry.guestUserEncodedData:
        return GsaServiceCacheI18N._guestUserEncodedData.value.display;
      case GsaServiceCacheEntry.cookieConsentMandatory:
        return GsaServiceCacheI18N._cookieConsentMandatory.value.display;
      case GsaServiceCacheEntry.cookieConsentFunctionality:
        return GsaServiceCacheI18N._cookieConsentFunctional.value.display;
      case GsaServiceCacheEntry.cookieConsentStatistics:
        return GsaServiceCacheI18N._cookieConsentStatistical.value.display;
      case GsaServiceCacheEntry.cookieConsentMarketing:
        return GsaServiceCacheI18N._cookieConsentMarketing.value.display;
      case GsaServiceCacheEntry.bookmarks:
        return GsaServiceCacheI18N._bookmarks.value.display;
      case GsaServiceCacheEntry.shopSearchHistory:
        return GsaServiceCacheI18N._shopSearchHistory.value.display;
      case GsaServiceCacheEntry.themeBrightness:
        return GsaServiceCacheI18N._themeBrightness.value.display;
      case GsaServiceCacheEntry.firstAppOpenIso8601:
        return GsaServiceCacheI18N._firstAppOpenTime.value.display;
    }
  }
}
