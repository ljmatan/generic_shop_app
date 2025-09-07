import 'dart:convert';
import 'dart:convert' as dart_convert;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_content/content.dart';
import 'package:generic_shop_app_services/services.dart';

part 'base/service_i18n_base_translations.dart';
part 'enums/service_i18n_enum_language.dart';
part 'extensions/service_i18n_extension_date_time.dart';
part 'extensions/service_i18n_extension_string.dart';
part 'models/service_i18n_model_translated_value.dart';
part 'models/service_i18n_model_translation_value.dart';

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
  final translationEntries = <GsaServiceI18NLanguage, Map<Type, Map<String, Map<String, dynamic>?>>>{
    for (final language in GsaServiceI18NLanguage.values)
      language: {
        for (final type in _translatableTypes) type: {},
      },
  };

  @override
  Future<void> init() async {
    await super.init();
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final matchingLanguage = GsaServiceI18NLanguage.values.firstWhereOrNull(
      (language) {
        return language.locale == systemLocale;
      },
    );
    if (matchingLanguage != null) {
      language = matchingLanguage;
    }
    final translations = GsaServiceCacheEntry.translations.value;
    if (translations is Iterable) {
      final translationValues = <GsaServiceI18NModelTranslationValue>[];
      for (final translationValueEncoded in translations) {
        try {
          final translationValueDecoded = jsonDecode(translationValueEncoded);
          final translationValue = GsaServiceI18NModelTranslationValue.fromJson(
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
        translationEntries[translationValue.language!]![translationValue.ancestor!]![translationValue.id!] = {
          'value': translationValue.value,
          'route': translationValue.route,
        };
      }
    } else {
      try {
        final translations = await rootBundle
            .loadString(
          'packages/${GsaConfig.plugin.id}/assets/translations/all.json',
        )
            .timeout(
          const Duration(seconds: 3),
          onTimeout: () {
            throw Exception(
              'Translation asset file read timeout.',
            );
          },
        );
      } catch (e) {
        GsaServiceLogging.instance.logError(
          'Error decoding asset translation:\n$e',
        );
      }
    }
  }

  /// Method for extracting the nearest available reference type for [translationEntries] extraction.
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
    final translatedValue = translationEntries[specifiedLanguage]?[ancestor]?[value];
    if (translatedValue == null) {
      for (final language in GsaServiceI18NLanguage.values) {
        translationEntries[language]?[ancestor]?[value] = {
          'value': null,
          'route': route.toString(),
        };
      }
    }
    if (GsaConfig.editMode) {
      Future.delayed(
        Duration.zero,
        () async {
          final translationValues = <GsaServiceI18NModelTranslationValue>[];
          for (final language in translationEntries.keys) {
            for (final type in translationEntries[language]!.keys) {
              for (final translatableValue in translationEntries[language]![type]!.entries) {
                translationValues.add(
                  GsaServiceI18NModelTranslationValue._(
                    ancestor: type,
                    route: translatableValue.value?['route'] == null
                        ? null
                        : _translatableRouteTypes.firstWhereOrNull(
                            (routeType) {
                              return routeType.toString() == translatableValue.value?['route'];
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
    }
    return translatedValue?['value'];
  }

  /// JSON encoder that creates multi-line formatted JSON.
  ///
  final jsonEncoder = dart_convert.JsonEncoder.withIndent('  ');

  String get translationValuesJsonEncoded {
    return jsonEncoder.convert(
      {
        for (final language in translationEntries.keys)
          language.name: {
            if (translationEntries[language] != null)
              for (final type in translationEntries[language]!.keys)
                type.toString(): {
                  if (translationEntries[language]![type] != null)
                    for (final entry in translationEntries[language]![type]!.entries)
                      entry.key: {
                        'value': entry.value?['value'],
                        'route': entry.value?['route']?.toString(),
                      },
                },
          },
      },
    );
  }

  final translatedValues = <List<GsaServiceI18NBaseTranslations>>[
    // Routes
    GsaRouteLoginI18N.values,
    GsaRouteCartI18N.values,
    // Widgets
    GsaWidgetCookieConsentI18N.values,
    GsaWidgetOverlayConfirmationI18N.values,
    // Services
    GsaServiceCacheI18N.values,
    ...GsaConfig.plugin.translations,
  ];
}
