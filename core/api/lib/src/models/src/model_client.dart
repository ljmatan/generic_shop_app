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
    this.personalDetails,
    this.contactDetails,
    this.deliveryAddresses,
    this.invoiceAddresses,
    this.originData,
  });

  /// Personal details.
  ///
  GsaModelPerson? personalDetails;

  /// Contact details.
  ///
  GsaModelContact? contactDetails;

  /// Delivery and invoice addresses available with this client.
  ///
  List<GsaModelAddress>? deliveryAddresses, invoiceAddresses;

  /// Method user by plugin implementations to serialise data from JSON.
  ///
  static Function(dynamic json)? originDataFromJson;

  static dynamic _originDataFromJson(dynamic json) {
    if (originDataFromJson == null || json == null) {
      return null;
    }
    try {
      return originDataFromJson!(json);
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }

  static dynamic _originDataToJson(dynamic value) {
    try {
      return value?.toJson();
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }

  /// The model object this class has been derived from.
  ///
  @JsonKey(
    fromJson: GsaModelClient._originDataFromJson,
    toJson: GsaModelClient._originDataToJson,
  )
  dynamic originData;

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
      personalDetails: GsaModelPerson.mock(),
      contactDetails: GsaModelContact.mock(),
      deliveryAddresses: [
        for (int i = 0; i < 2; i++) GsaModelAddress.mock(),
      ],
      invoiceAddresses: [
        GsaModelAddress.mock(),
      ],
    );
  }
}
