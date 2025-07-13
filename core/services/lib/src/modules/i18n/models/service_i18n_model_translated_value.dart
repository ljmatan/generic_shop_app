part of '../service_i18n.dart';

class GsaServiceI18NModelTranslatedValue {
  const GsaServiceI18NModelTranslatedValue(
    this.value, {
    required this.enIe,
    required this.enGb,
    required this.de,
    required this.it,
    required this.fr,
    required this.es,
    required this.hr,
    required this.cz,
  });

  final String value;

  final String? enIe, enGb, de, it, fr, es, hr, cz;

  String get display {
    return switch (GsaServiceI18N.instance.language) {
          GsaServiceI18NLanguage.enUs => value,
          GsaServiceI18NLanguage.enIe => enIe,
          GsaServiceI18NLanguage.enGb => enGb,
          GsaServiceI18NLanguage.de => de,
          GsaServiceI18NLanguage.it => it,
          GsaServiceI18NLanguage.fr => fr,
          GsaServiceI18NLanguage.es => es,
          GsaServiceI18NLanguage.hr => hr,
          GsaServiceI18NLanguage.cz => cz,
        } ??
        value;
  }
}
