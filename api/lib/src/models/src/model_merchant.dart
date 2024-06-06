part of '../models.dart';

/// Model class with definitions of merchant / vendor methods and properties.
///
@JsonSerializable(explicitToJson: true)
class GsaaModelMerchant extends _Model {
  // ignore: public_member_api_docs
  GsaaModelMerchant({
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

  // ignore: public_member_api_docs
  factory GsaaModelMerchant.fromJson(Map json) {
    return _$GsaaModelMerchantFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelMerchantToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaaModelMerchant.mock({
    String? categoryId,
  }) {
    return GsaaModelMerchant(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      categoryId: categoryId,
      name: _Model._generateRandomString(20),
      contact: GsaaModelContact.mock(),
      address: GsaaModelAddress.mock(),
      logoImageUrl: 'https://picsum.photos/${1000 + Random().nextInt(100)}/${1600 + Random().nextInt(100)}',
      logoImageSmallUrl: 'https://picsum.photos/${200 + Random().nextInt(100)}/${300 + Random().nextInt(100)}',
    );
  }
}
