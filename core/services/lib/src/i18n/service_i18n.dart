import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

part 'extensions/service_i18n_extension_date_time.dart';

/// Central access point for the internationalization services.
///
class GsaServiceI18N extends GsaService {
  GsaServiceI18N._();

  static final _instance = GsaServiceI18N._();

  // ignore: public_member_api_docs
  static GsaServiceI18N get instance => _instance() as GsaServiceI18N;

  /// The specified runtime display language.
  ///
  GsaServiceI18NLanguage language = GsaServiceI18NLanguage.enUs;

  /// Collection of translated app display values.
  ///
  /// The value is represented by the following format:
  ///
  /// ```dart
  /// // Example type definition for the translation content reference.
  /// ExampleType: {
  ///   // Identifier for the language the value will be translated into.
  ///   GsaServiceI18NLanguage.enUk: {
  ///     // Text is translated from English (US) source,
  ///     // and identified with a [Map.key] value in this language.
  ///     'Color': 'Colour',
  ///   },
  /// },
  /// ```
  ///
  final _values = <GsaServiceI18NLanguage, Map<Type, Map<String, String?>>>{
    for (final language in GsaServiceI18NLanguage.values) language: {},
  };

  /// [Type] objects for which the translation is defined for.
  ///
  static final widgetTypes = GsaWidgets.values.map(
    (widget) {
      return widget.widgetRuntimeType;
    },
  ).toList()
    ..remove(GsaWidgetText);

  /// [Type] objects for which the translation is defined for.
  ///
  static final _translatableTypes = <Type>[
    ...GsaRoutes.values.map(
      (route) {
        return route.routeRuntimeType;
      },
    ),
    if (GsaConfig.plugin.routes != null)
      ...GsaConfig.plugin.routes!.map(
        (route) {
          return route.routeRuntimeType;
        },
      ),
    ...widgetTypes,
  ];

  @override
  Future<void> init() async {
    await super.init();
    final translations = GsaServiceCacheEntry.translations.value;
    if (translations is Iterable) {
      final translationValues = <GsaServiceI18NTranslationValue>[];
      for (final translationValueEncoded in translations) {
        try {
          final translationValueDecoded = jsonDecode(translationValueEncoded);
          final translationValue = GsaServiceI18NTranslationValue.fromJson(
            translationValueDecoded,
          );
          if (translationValue.ancestor != null && translationValue.language != null) {
            translationValues.add(translationValue);
          } else {}
        } catch (e) {
          GsaServiceLogging.instance.logError(
            'Error decoding translation:\n$e',
          );
        }
      }
      for (final translationValue in translationValues) {
        _values[translationValue.language!] ??= {};
        _values[translationValue.language!]![translationValue.ancestor!] ??= {};
        _values[translationValue.language!]![translationValue.ancestor!]![translationValue.id] = translationValue.value;
      }
    } else {
      try {
        final translations = await rootBundle.loadString(
          'packages/generic_shop_app_services/assets/translations/all.json',
        );
      } catch (e) {
        GsaServiceLogging.instance.logError(
          'Error decoding asset translation:\n$e',
        );
      }
    }
  }

  /// Method used for translating text content.
  ///
  /// Method requires an [ancestor] definition for which the translation is defined,
  /// a [value] representing the identifier for the value to be translated,
  /// as well as an optional [language] identifier for specifying the result language.
  ///
  String? translate({
    required Type ancestor,
    required String value,
    GsaServiceI18NLanguage? language,
  }) {
    final specifiedLanguage = language ?? instance.language;
    final translatedValue = _values[specifiedLanguage]?[ancestor]?[value];
    if (translatedValue == null) {
      _values[specifiedLanguage] ??= {};
      _values[specifiedLanguage]![ancestor] ??= {};
      _values[specifiedLanguage]![ancestor]![value] = null;
    }
    Future.delayed(
      Duration.zero,
      () async {
        final translationValues = <GsaServiceI18NTranslationValue>[];
        for (final language in _values.keys) {
          for (final type in _values[language]!.keys) {
            for (final translatableValue in _values[language]![type]!.entries) {
              translationValues.add(
                GsaServiceI18NTranslationValue._(
                  ancestor: type,
                  language: language,
                  id: translatableValue.key,
                  value: translatableValue.value,
                ),
              );
            }
          }
        }
        final cachedTranslationValues = translationValues.map(
          (translationValue) {
            return jsonEncode(
              translationValue.toJson(),
            );
          },
        ).toList();
        await GsaServiceCacheEntry.translations.setValue(cachedTranslationValues);
      },
    );
    return translatedValue;
  }
}

/// Unique language identifiers.
///
enum GsaServiceI18NLanguage {
  /// English (US) language.
  ///
  enUs,

  /// English (Ireland).
  ///
  enIr,

  /// English (United Kingdom).
  ///
  enUk,

  /// German language.
  ///
  de,

  /// Italian language.
  ///
  it,

  /// French language.
  ///
  fr,

  /// Spanish language.
  ///
  es,

  /// Croatian language.
  ///
  hr,

  /// Czech language.
  ///
  cz;

  /// Currency display name visible to the user.
  ///
  String get displayName {
    switch (this) {
      case GsaServiceI18NLanguage.enUs:
        return 'English (United States)';
      case GsaServiceI18NLanguage.enIr:
        return 'English (Ireland)';
      case GsaServiceI18NLanguage.enUk:
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

/// Object defining translatable text value properties.
///
class GsaServiceI18NTranslationValue {
  GsaServiceI18NTranslationValue._({
    required this.ancestor,
    required this.language,
    required this.id,
    required this.value,
  });

  /// Widget specified with a text value.
  ///
  final Type? ancestor;

  /// The specified language of this text value.
  ///
  final GsaServiceI18NLanguage? language;

  /// The original (non-translated) value defined for this object.
  ///
  final String id;

  /// The text value specified for this object.
  ///
  final String? value;

  /// Factory method for constructing this object from a [Map] object.
  ///
  factory GsaServiceI18NTranslationValue.fromJson(Map json) {
    return GsaServiceI18NTranslationValue._(
      ancestor: GsaServiceI18N._translatableTypes.firstWhereOrNull(
        (typeId) {
          return typeId.toString() == json['ancestor'];
        },
      ),
      language: GsaServiceI18NLanguage.values.firstWhereOrNull(
        (languageEntry) {
          return languageEntry.name == json['language'];
        },
      ),
      id: json['id'],
      value: json['value'],
    );
  }

  /// Method for generating a [Map]-type object from this class instance.
  ///
  Map<String, String?> toJson() {
    return {
      'ancestor': ancestor?.toString(),
      'language': language?.name,
      'id': id,
      'value': value,
    };
  }
}
