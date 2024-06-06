part of '../models.dart';

/// Contact details parameters.
///
@JsonSerializable(explicitToJson: true)
class GsaaModelContact extends _Model {
  // ignore: public_member_api_docs
  GsaaModelContact({
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
  GsaaModelPerson? personalDetails;

  /// Address details associated with this contact entity.
  ///
  GsaaModelAddress? addressDetails;

  // ignore: public_member_api_docs
  factory GsaaModelContact.fromJson(Map json) {
    return _$GsaaModelContactFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelContactToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaaModelContact.mock() {
    return GsaaModelContact(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      email: '${_Model._generateRandomString(8)}@email.com',
      phoneCountryCode: '1',
      phoneNumber: _Model._generateRandomNumber(8).toString(),
    );
  }
}
