import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Contact details parameters.
///
@GsarModelMacro()
class GsaaModelContact {
  // ignore: public_member_api_docs
  GsaaModelContact({
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
}
