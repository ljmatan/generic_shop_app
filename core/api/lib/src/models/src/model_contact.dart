part of '../models.dart';

/// Contact details parameters.
///
@JsonSerializable(explicitToJson: true)
class GsaModelContact extends _Model {
  // ignore: public_member_api_docs
  GsaModelContact({
    super.id,
    super.originId,
    super.categoryId,
    this.email,
    this.phoneCountryCode,
    this.phoneNumber,
    this.note,
    this.personalDetails,
    this.addressDetails,
  });

  /// Email address.
  ///
  String? email;

  /// Phone number details.
  ///
  String? phoneCountryCode, phoneNumber;

  /// Formats and joins the [phoneCountryCode] and the [phoneNumber] properties.
  ///
  String? get formattedPhoneNumber => phoneCountryCode != null && phoneNumber != null ? '+$phoneCountryCode$phoneNumber' : null;

  /// Custom note specified for the given contact details.
  ///
  String? note;

  /// Personal user details associated with this contact.
  ///
  GsaModelPerson? personalDetails;

  /// Address details associated with this contact entity.
  ///
  GsaModelAddress? addressDetails;

  // ignore: public_member_api_docs
  factory GsaModelContact.fromJson(Map json) {
    return _$GsaModelContactFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelContactToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelContact.mock() {
    return GsaModelContact(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      email: '${_Model._generateRandomString(8)}@email.com',
      phoneCountryCode: '1',
      phoneNumber: _Model._generateRandomNumber(8).toString(),
    );
  }
}
