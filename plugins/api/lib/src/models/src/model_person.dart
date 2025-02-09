part of '../models.dart';

/// Class representing person details such as first and last name or date of birth.
///
@JsonSerializable(explicitToJson: true)
class GsaModelPerson extends _Model {
  // ignore: public_member_api_docs
  GsaModelPerson({
    super.id,
    super.originId,
    super.categoryId,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirthIso8601,
  });

  /// User first and last name.
  ///
  String? firstName, lastName;

  /// Formats and joins the [firstName] and the [lastName] properties.
  ///
  String get formattedName => '$firstName $lastName';

  /// Given gender for the person.
  ///
  String? gender;

  /// Person date of birth in the ISO 8601 format.
  ///
  String? dateOfBirthIso8601;

  /// Person date of birth in the [DateTime] format.
  ///
  DateTime? get dateOfBirth => dateOfBirthIso8601 != null ? DateTime.tryParse(dateOfBirthIso8601!) : null;

  // ignore: public_member_api_docs
  factory GsaModelPerson.fromJson(Map json) {
    return _$GsaModelPersonFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelPersonToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelPerson.mock({
    String? categoryId,
  }) {
    return GsaModelPerson(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      firstName: _Model._generateRandomString(8),
      lastName: _Model._generateRandomString(8),
      gender: _Model._generateRandomString(6),
      dateOfBirthIso8601: DateTime.now().toIso8601String(),
    );
  }
}
