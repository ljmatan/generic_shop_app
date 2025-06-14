part of '../models.dart';

@JsonSerializable(explicitToJson: true)
class GsaModelSalePoint extends _Model {
  GsaModelSalePoint({
    super.id,
    super.originId,
    this.name,
    this.address,
  });

  GsaModelTranslated? name;

  GsaModelAddress? address;

  // ignore: public_member_api_docs
  factory GsaModelSalePoint.fromJson(Map json) {
    return _$GsaModelSalePointFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelSalePointToJson(this);
  }
}
