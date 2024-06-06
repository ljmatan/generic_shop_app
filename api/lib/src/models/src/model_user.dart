part of '../models.dart';

/// Details associated with the service user.
///
@JsonSerializable(explicitToJson: true)
class GsaaModelUser extends _Model {
  // ignore: public_member_api_docs
  GsaaModelUser({
    super.id,
    super.originId,
    super.categoryId,
    this.username,
    this.personalDetails,
    this.contact,
    this.address,
    this.deliveryAddresses,
    this.invoiceAddresses,
  });

  /// Custom username for the given user.
  ///
  String? username;

  /// User personal details such as first and last name.
  ///
  GsaaModelPerson? personalDetails;

  /// User contact details such as email or phone number.
  ///
  GsaaModelContact? contact;

  /// User address details such as street name and house number.
  ///
  GsaaModelAddress? address;

  /// Addresses specified for the sale item delivery.
  ///
  List<GsaaModelAddress>? deliveryAddresses;

  /// The legal address of the buyer or the address where they receive correspondence.
  ///
  List<GsaaModelAddress>? invoiceAddresses;

  // ignore: public_member_api_docs
  factory GsaaModelUser.fromJson(Map json) {
    return _$GsaaModelUserFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelUserToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaaModelUser.mock() {
    return GsaaModelUser(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      categoryId: _Model._generateRandomString(8),
      personalDetails: GsaaModelPerson.mock(),
      username: _Model._generateRandomString(8),
      contact: GsaaModelContact.mock(),
      address: GsaaModelAddress.mock(),
    );
  }
}
