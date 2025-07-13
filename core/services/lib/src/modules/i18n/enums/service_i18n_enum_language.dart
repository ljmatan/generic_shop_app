part of '../service_i18n.dart';

/// Unique language identifiers.
///
enum GsaServiceI18NLanguage {
  /// English (US) language.
  ///
  enUs(
    Locale('en', 'US'),
  ),

  /// English (Ireland).
  ///
  enIe(
    Locale('en', 'IE'),
  ),

  /// English (United Kingdom).
  ///
  enGb(
    Locale('en', 'GB'),
  ),

  /// German language.
  ///
  de(
    Locale('de', 'DE'),
  ),

  /// Italian language.
  ///
  it(
    Locale('it', 'IT'),
  ),

  /// French language.
  ///
  fr(
    Locale('fr', 'FR'),
  ),

  /// Spanish language.
  ///
  es(
    Locale('es', 'ES'),
  ),

  /// Croatian language.
  ///
  hr(
    Locale('hr', 'HR'),
  ),

  /// Czech language.
  ///
  cz(
    Locale('cs', 'CZ'),
  );

  const GsaServiceI18NLanguage(
    this.locale,
  );

  /// An identifier used to select a user's language and formatting preferences.
  ///
  final Locale locale;

  /// Currency display name visible to the user.
  ///
  String get displayName {
    switch (this) {
      case GsaServiceI18NLanguage.enUs:
        return 'English (United States)';
      case GsaServiceI18NLanguage.enIe:
        return 'English (Ireland)';
      case GsaServiceI18NLanguage.enGb:
        return 'English (United Kingdom)';
      case GsaServiceI18NLanguage.de:
        return 'Deutsch';
      case GsaServiceI18NLanguage.it:
        return 'Italian';
      case GsaServiceI18NLanguage.fr:
        return 'French';
      case GsaServiceI18NLanguage.es:
        return 'Spanish';
      case GsaServiceI18NLanguage.hr:
        return 'Croatian';
      case GsaServiceI18NLanguage.cz:
        return 'Czech';
    }
  }
}
