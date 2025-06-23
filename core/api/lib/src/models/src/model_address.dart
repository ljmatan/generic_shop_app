part of '../models.dart';

/// Generic-format address details.
///
@JsonSerializable(explicitToJson: true)
class GsaModelAddress extends _Model {
  // ignore: public_member_api_docs
  GsaModelAddress({
    super.id,
    super.originId,
    super.categoryId,
    this.streetName,
    this.houseNumber,
    this.zipCode,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.note,
    this.personalDetails,
    this.contactDetails,
  });

  /// Custom display name specified for [this] address.
  ///
  String? displayName;

  /// Street name for the given address.
  ///
  String? streetName;

  /// House number on the street.
  ///
  String? houseNumber;

  /// Location zip code / post code.
  ///
  String? zipCode;

  /// Location zip code / post code.
  ///
  String? get postcode => zipCode;

  /// City specified for the address.
  ///
  String? city;

  /// State specified for the address.
  ///
  String? state;

  /// Country the address is specified for.
  ///
  String? country;

  /// Formatted address display.
  ///
  /// Combines available fields into a readable format.
  ///
  String? get addressFormatted {
    final parts = [
      if (streetName != null && houseNumber != null)
        '$streetName $houseNumber'
      else if (streetName != null)
        streetName
      else if (houseNumber != null)
        houseNumber,
      if (zipCode != null && city != null) '$zipCode $city' else if (zipCode != null) zipCode else if (city != null) city,
      if (state != null) state,
      if (country != null) country,
    ];
    final nonEmptyParts = parts
        .whereType<String>()
        .where(
          (s) => s.trim().isNotEmpty,
        )
        .toList();
    if (nonEmptyParts.isEmpty) return null;
    return nonEmptyParts.join(', ');
  }

  /// Coordinates in latitude and longitude.
  ///
  double? latitude, longitude;

  /// Helper method for coordinate value management.
  ///
  (double, double)? get coordinates {
    return latitude != null && longitude != null ? (latitude!, longitude!) : null;
  }

  /// Custom notes for the given address.
  ///
  String? note;

  /// Custom personal details associated with the address.
  ///
  GsaModelPerson? personalDetails;

  /// Custom contact details associated with the address.
  ///
  GsaModelContact? contactDetails;

  // ignore: public_member_api_docs
  factory GsaModelAddress.fromJson(Map json) {
    return _$GsaModelAddressFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelAddressToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelAddress.mock() {
    return GsaModelAddress(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      categoryId: _Model._generateRandomString(8),
      streetName: _Model._generateRandomString(12),
      houseNumber: _Model._generateRandomString(3),
      zipCode: _Model._generateRandomNumber(5).toString(),
      city: _Model._generateRandomString(8),
      state: _Model._generateRandomString(8),
      country: _Model._generateRandomString(8),
      note: _Model._generateRandomString(40),
      latitude: 45.75 + Random().nextDouble() * .2,
      longitude: 15.9 + Random().nextDouble() * .2,
      personalDetails: GsaModelPerson.mock(),
      contactDetails: GsaModelContact.mock(),
    );
  }
}
