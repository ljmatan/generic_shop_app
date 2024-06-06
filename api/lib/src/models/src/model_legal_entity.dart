part of '../models.dart';

@JsonSerializable(explicitToJson: true)
class GsaModelLegalEntity extends _Model {
  GsaModelLegalEntity({
    super.id,
    super.originId,
    this.name,
    this.address,
  });

  GsaaModelTranslated? name;

  GsaaModelAddress? address;

  // ignore: public_member_api_docs
  factory GsaModelLegalEntity.fromJson(Map json) {
    return _$GsaModelLegalEntityFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelLegalEntityToJson(this);
  }
}
