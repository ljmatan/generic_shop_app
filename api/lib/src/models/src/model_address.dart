import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Generic-format address details.
///
@GsarModelMacro()
class GsaaModelAddress extends GsarModel {
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

  /// Coordinates in latitude and longitude.
  ///
  double? latitude, longitude;

  /// Helper method for coordinate value management.
  ///
  (double, double)? get coordinates => latitude != null && longitude != null ? (latitude!, longitude!) : null;

  /// Custom notes for the given address.
  ///
  String? note;

  /// Custom personal details associated with the address.
  ///
  GsaaModelPerson? personalDetails;

  /// Custom contact details associated with the address.
  ///
  GsaaModelContact? contactDetails;
}
