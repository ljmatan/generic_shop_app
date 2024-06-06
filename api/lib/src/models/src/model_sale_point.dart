part of '../models.dart';

@JsonSerializable(explicitToJson: true)
class GsaaModelSalePoint extends _Model {
  GsaaModelSalePoint({
    super.id,
    super.originId,
    this.name,
    this.address,
  });

  GsaaModelTranslated? name;

  GsaaModelAddress? address;

  // ignore: public_member_api_docs
  factory GsaaModelSalePoint.fromJson(Map json) {
    return _$GsaaModelSalePointFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelSalePointToJson(this);
  }
}
