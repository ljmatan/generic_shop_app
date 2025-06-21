part of '../models.dart';

/// Details associated with the service user.
///
@JsonSerializable(explicitToJson: true)
class GsaModelUser extends _Model {
  // ignore: public_member_api_docs
  GsaModelUser({
    super.id,
    super.originId,
    super.categoryId,
    this.username,
    this.personalDetails,
    this.contact,
    this.address,
    this.deliveryAddresses,
    this.invoiceAddresses,
    this.originData,
  });

  /// Custom username for the given user.
  ///
  String? username;

  /// User personal details such as first and last name.
  ///
  GsaModelPerson? personalDetails;

  /// User contact details such as email or phone number.
  ///
  GsaModelContact? contact;

  /// User address details such as street name and house number.
  ///
  GsaModelAddress? address;

  /// Addresses specified for the sale item delivery.
  ///
  List<GsaModelAddress>? deliveryAddresses;

  /// The legal address of the buyer or the address where they receive correspondence.
  ///
  List<GsaModelAddress>? invoiceAddresses;

  /// Method user by plugin implementations to serialise data from JSON.
  ///
  static Function(dynamic json)? originDataFromJson;

  static dynamic _originDataFromJson(dynamic json) {
    if (originDataFromJson == null || json == null) {
      return null;
    }
    try {
      return originDataFromJson!(json);
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }

  static dynamic _originDataToJson(dynamic value) {
    try {
      return value?.toJson();
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }

  /// The model object this class has been derived from.
  ///
  @JsonKey(
    fromJson: GsaModelUser._originDataFromJson,
    toJson: GsaModelUser._originDataToJson,
  )
  dynamic originData;

  factory GsaModelUser.fromJson(Map json) {
    return _$GsaModelUserFromJson(Map<String, dynamic>.from(json));
  }

  Map<String, dynamic> toJson() {
    return _$GsaModelUserToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelUser.mock() {
    return GsaModelUser(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      categoryId: _Model._generateRandomString(8),
      personalDetails: GsaModelPerson.mock(),
      username: _Model._generateRandomString(8),
      contact: GsaModelContact.mock(),
      address: GsaModelAddress.mock(),
    );
  }
}
