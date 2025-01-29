import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Model class with definitions of merchant / vendor methods and properties.
///
@GsarModelMacro()
class GsaaModelMerchant {
  // ignore: public_member_api_docs
  GsaaModelMerchant({
    this.originUrl,
    this.name,
    this.contact,
    this.address,
    this.logoImageUrl,
    this.logoImageSmallUrl,
    this.reviews,
  });

  String? originUrl;

  /// Merchant display name.
  ///
  String? name;

  /// Merchant contact details
  ///
  GsaaModelContact? contact;

  /// Merchant address details.
  ///
  GsaaModelAddress? address;

  /// Graphical logo representation.
  ///
  String? logoImageUrl, logoImageSmallUrl;

  /// List of available reviews for this merchant.
  ///
  List<GsaaModelReview>? reviews;
}
