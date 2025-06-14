part of '../models.dart';

/// Model class with definitions of merchant / vendor methods and properties.
///
@JsonSerializable(explicitToJson: true)
class GsaModelMerchant extends _Model {
  // ignore: public_member_api_docs
  GsaModelMerchant({
    super.id,
    super.originId,
    super.categoryId,
    this.name,
    this.contact,
    this.address,
    this.logoImageUrl,
    this.logoImageSmallUrl,
    this.reviews,
  });

  /// Merchant display name.
  ///
  String? name;

  /// Merchant contact details
  ///
  GsaModelContact? contact;

  /// Merchant address details.
  ///
  GsaModelAddress? address;

  /// Graphical logo representation.
  ///
  String? logoImageUrl, logoImageSmallUrl;

  /// List of available reviews for this merchant.
  ///
  List<GsaModelReview>? reviews;

  // ignore: public_member_api_docs
  factory GsaModelMerchant.fromJson(Map json) {
    return _$GsaModelMerchantFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelMerchantToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelMerchant.mock({
    String? categoryId,
  }) {
    return GsaModelMerchant(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      categoryId: categoryId,
      name: _Model._generateRandomString(20),
      contact: GsaModelContact.mock(),
      address: GsaModelAddress.mock(),
      logoImageUrl: 'https://picsum.photos/${1000 + Random().nextInt(100)}/${1600 + Random().nextInt(100)}',
      logoImageSmallUrl: 'https://picsum.photos/${200 + Random().nextInt(100)}/${300 + Random().nextInt(100)}',
    );
  }
}
