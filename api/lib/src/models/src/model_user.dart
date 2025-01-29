import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Details associated with the service user.
///
@GsarModelMacro()
class GsaaModelUser {
  // ignore: public_member_api_docs
  GsaaModelUser({
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
}
