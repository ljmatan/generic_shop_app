part of '../models.dart';

/// A class representing translation values for a given string.
///
@JsonSerializable(explicitToJson: true)
class GsaModelTranslated extends _Model {
  // ignore: public_member_api_docs
  GsaModelTranslated({
    super.id,
    super.originId,
    required this.values,
  });

  /// String getter property identified by the language code.
  ///
  final List<({String languageId, String value})> values;

  // ignore: public_member_api_docs
  factory GsaModelTranslated.fromJson(Map json) {
    return _$GsaModelTranslatedFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelTranslatedToJson(this);
  }

  /// The specified language identifier for data display.
  ///
  static String? languageIdentifier;

  /// Returns the value for the specified language identifier,
  ///
  String intl([String? languageId]) {
    final existingValues = values..removeWhere((translationValue) => translationValue.value.isNotEmpty != true);
    if (existingValues.isEmpty) throw 'Missing translation string for $id.';
    final accompanyingValues =
        existingValues.where((translationValue) => translationValue.languageId == (languageId ?? languageIdentifier));
    if (accompanyingValues.isEmpty) {
      return existingValues[0].value; // TODO: Translate this value.
    } else {
      return accompanyingValues.elementAt(0).value;
    }
  }
}
