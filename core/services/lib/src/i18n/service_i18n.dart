import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

part 'extensions/service_i18n_extension_date_time.dart';
part 'extensions/service_i18n_extension_string.dart';

/// Central access point for the internationalization services.
///
class GsaServiceI18N extends GsaService {
  GsaServiceI18N._();

  static final _instance = GsaServiceI18N._();

  /// Globally-accessible singleton class instance.
  ///
  static GsaServiceI18N get instance => _instance() as GsaServiceI18N;

  /// [Type] widget objects for which the translation is defined for.
  ///
  static final _translatableWidgetTypes = GsaWidgets.values.map(
    (widget) {
      return widget.widgetRuntimeType;
    },
  ).toList()
    ..remove(GsaWidgetText);

  /// [Type] route objects for which the translation is defined for.
  ///
  static final _translatableRouteTypes = [
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
  ];

  /// [Type] objects for which the translation is defined for.
  ///
  static final _translatableTypes = <Type>[
    ..._translatableRouteTypes,
    ..._translatableWidgetTypes,
  ];

  /// The specified runtime display language.
  ///
  GsaServiceI18NLanguage language = GsaServiceI18NLanguage.enUs;

  /// Collection of translated app display values.
  ///
  /// The value is represented with the following (example) format:
  ///
  /// ```dart
  /// GsaServiceI18NLanguage.enUs: {
  ///   ExampleType: {
  ///     // English (US) values are entered by default.
  ///     'Color': null,
  ///   },
  /// },
  /// GsaServiceI18NLanguage.enUk: {
  ///   ExampleType: {
  ///     // Text is translated from English (US) source,
  ///     // and identified with a [Map.key] value in this language.
  ///     'Color': 'Colour',
  ///   },
  /// },
  /// ```
  ///
  final _values = <GsaServiceI18NLanguage, Map<Type, Map<String, Map<String, dynamic>?>>>{
    for (final language in GsaServiceI18NLanguage.values)
      language: {
        for (final type in _translatableTypes) type: {},
      },
  };

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
        if (translationValue.id == null) {
          continue;
        }
        _values[translationValue.language!]![translationValue.ancestor!]![translationValue.id!] = {
          'value': translationValue.value,
          'route': translationValue.route,
        };
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

  /// Method for extracting the nearest available reference type for [_values] extraction.
  ///
  ({
    Type ancestor,
    GsaRoute? route,
  })? getTranslationReference(
    BuildContext context,
  ) {
    ({
      Type ancestor,
      GsaRoute? route,
    })? translationReference;
    final ancestorElements = <Element>[];
    if (context.findAncestorWidgetOfExactType<GsaWidgetAppBar>() != null) {
      GsaRoute? ancestorRoute;
      context.visitAncestorElements(
        (element) {
          if (element.widget is GsaRoute) {
            ancestorRoute = element.widget as GsaRoute;
            return false;
          }
          ancestorElements.add(element);
          return true;
        },
      );
      for (final ancestor in ancestorElements) {
        final matchingType = _translatableWidgetTypes.firstWhereOrNull(
          (widgetType) {
            return widgetType == ancestor.widget.runtimeType;
          },
        );
        if (matchingType != null) {
          translationReference = (
            ancestor: matchingType,
            route: ancestorRoute,
          );
          break;
        }
      }
    }
    if (translationReference == null) {
      final GsaRoute? ancestorRoute = ancestorElements.firstWhereOrNull(
            (element) {
              return element.runtimeType is GsaRoute;
            },
          )?.widget as GsaRoute? ??
          context.findAncestorStateOfType<GsaRouteState>()?.widget;
      if (ancestorRoute?.translatable == true) {
        return (
          ancestor: ancestorRoute.runtimeType,
          route: null,
        );
      }
    }
    return translationReference;
  }

  /// Method used for translating text content.
  ///
  /// Method requires an [ancestor] definition for which the translation is defined,
  /// a [value] representing the identifier for the value to be translated,
  /// as well as an optional [language] identifier for specifying the result language.
  ///
  String? translate({
    required Type ancestor,
    Type? route,
    required String value,
    GsaServiceI18NLanguage? language,
  }) {
    final specifiedLanguage = language ?? instance.language;
    final translatedValue = _values[specifiedLanguage]?[ancestor]?[value];
    if (translatedValue == null) {
      _values[specifiedLanguage]![ancestor]![value] = {
        'value': null,
        'route': route,
      };
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
                  route: translatableValue.value?['route'] == null
                      ? null
                      : _translatableTypes.firstWhereOrNull(
                          (type) {
                            return type.toString() == translatableValue.value!['route'];
                          },
                        ),
                  language: language,
                  id: translatableValue.key,
                  value: translatableValue.value?['value'],
                ),
              );
            }
          }
        }
        if (kDebugMode || GsaConfig.editMode) {
          final cachedTranslationValues = translationValues.map(
            (translationValue) {
              return jsonEncode(
                translationValue.toJson(),
              );
            },
          ).toList();
          await GsaServiceCacheEntry.translations.setValue(cachedTranslationValues);
        }
      },
    );
    return translatedValue?['value'];
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
    required this.route,
    required this.language,
    required this.id,
    required this.value,
  });

  /// Widget specified with a text value.
  ///
  final Type? ancestor;

  /// Route the [ancestor] is specified with.
  ///
  /// If [ancestor] is defined within the [GsaServiceI18N.translatableWidgetTypes],
  /// this information is appended as well for more thorough definition.
  ///
  final Type? route;

  /// The specified language of this text value.
  ///
  final GsaServiceI18NLanguage? language;

  /// The original (non-translated) value defined for this object.
  ///
  final String? id;

  /// The text value specified for this object.
  ///
  final String? value;

  /// Factory method for constructing this object from a [Map] object.
  ///
  factory GsaServiceI18NTranslationValue.fromJson(Map json) {
    return GsaServiceI18NTranslationValue._(
      ancestor: json['ancestor'] == null
          ? null
          : GsaServiceI18N._translatableTypes.firstWhereOrNull(
              (typeId) {
                return typeId.toString() == json['ancestor'];
              },
            ),
      route: json['route'] == null
          ? null
          : GsaServiceI18N._translatableRouteTypes.firstWhereOrNull(
              (route) {
                return route.toString() == json['route'];
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
      'route': route?.toString(),
      'language': language?.name,
      'id': id,
      'value': value,
    };
  }
}
