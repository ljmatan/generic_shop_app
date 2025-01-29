import 'package:generic_shop_app_architecture/gsar.dart';

/// Class representing person details such as first and last name or date of birth.
///
@GsarModelMacro()
class GsaaModelPerson {
  // ignore: public_member_api_docs
  GsaaModelPerson({
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
}
