part of '../models.dart';

///
///
@JsonSerializable(explicitToJson: true)
class GsaModelClient extends _Model {
  // ignore: public_member_api_docs
  GsaModelClient({
    super.id,
    super.originId,
    super.categoryId,
    required this.name,
  });

  /// Display name for the given client.
  ///
  String? name;

  // ignore: public_member_api_docs
  factory GsaModelClient.fromJson(Map json) {
    return _$GsaModelClientFromJson(
      Map<String, dynamic>.from(json),
    );
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelClientToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelClient.mock() {
    return GsaModelClient(
      name: _Model._generateRandomString(10),
    );
  }
}
