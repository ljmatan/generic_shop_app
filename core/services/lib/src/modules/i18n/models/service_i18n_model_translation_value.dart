part of '../service_i18n.dart';

/// Object defining translatable text value properties.
///
class GsaServiceI18NModelTranslationValue {
  GsaServiceI18NModelTranslationValue._({
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
  factory GsaServiceI18NModelTranslationValue.fromJson(Map json) {
    return GsaServiceI18NModelTranslationValue._(
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
                print('Route: "${route.toString()}"');
                print('"${json['route'].toString()}" ${json['route'].runtimeType}');
                print('Route: "${route.toString().codeUnits}"');
                print('"${json['route'].toString().codeUnits}" ${json['route'].runtimeType}');
                return route.toString() == json['route'] as String;
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
