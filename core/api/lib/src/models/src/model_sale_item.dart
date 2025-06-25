part of '../models.dart';

/// Object representing any sale item such as products, delivery services, etc.
///
@JsonSerializable(explicitToJson: true)
class GsaModelSaleItem extends _Model {
  // ignore: public_member_api_docs
  GsaModelSaleItem({
    super.id,
    super.originId,
    super.categoryId,
    this.name,
    this.productCode,
    this.amount,
    this.measure,
    this.description,
    this.disclaimer,
    this.imageUrls,
    this.thumbnailUrls,
    this.attributeIconUrls,
    this.price,
    this.availability,
    this.maxCount,
    this.featured,
    this.delivered,
    this.digital,
    this.payable,
    this.options,
    this.reviews,
    this.deliveryTimeMilliseconds,
    this.informationList,
    this.originData,
    super.originUrl,
    super.consentIds,
    super.tags,
  });

  /// Item display name.
  ///
  String? name;

  /// A unique, user-visible product code.
  ///
  String? productCode;

  static num? _amountFromJson(json) {
    return num.tryParse(json.toString());
  }

  /// The amount for sale with the given [measure].
  ///
  @JsonKey(fromJson: _amountFromJson)
  num? amount;

  /// Item measure (e.g., kg, lbs, m, etc.) for the given [amount].
  ///
  String? measure;

  /// Formatted representation of the amount and measure of the sale item.
  ///
  String? get amountMeasureFormatted {
    String value = '';
    if (amount != null) value += '$amount';
    if (measure != null) value += (amount != null ? ' ' : '') + '$measure ';
    return value.isEmpty ? null : value;
  }

  /// Client-facing item description.
  ///
  String? description;

  /// Product disclaimer, usually representing a legally-required notice.
  ///
  String? disclaimer;

  /// Item graphical representation.
  ///
  List<String>? imageUrls, thumbnailUrls, attributeIconUrls;

  /// Price associated with the item.
  ///
  GsaModelPrice? price;

  /// The amount of the current item in the cart or order draft.
  ///
  int? get cartCount {
    return GsaDataCheckout.instance.itemCount(this);
  }

  /// Availability information, including store location identifier or available item count.
  ///
  List<({String? locationId, int? count})>? availability;

  /// Maximum count of products to purchase in a single checkout session.
  ///
  int? maxCount;

  /// Whether this item is marked as a featured item.
  ///
  bool? featured;

  /// Whether this item is offered with delivery.
  ///
  bool? delivered;

  /// Whether the item is offered in digital format.
  ///
  bool? digital;

  /// Whether the payment options are applicable for this item.
  ///
  bool? payable;

  /// List of associated [GsaModelSaleItemOption] objects.
  ///
  List<GsaModelSaleItem>? options;

  /// List of available reviews for this sale item.
  ///
  List<GsaModelReview>? reviews;

  /// Delivery time for the sale item in milliseconds.
  ///
  int? deliveryTimeMilliseconds;

  /// Item condition (new, used, refurbished, etc.).
  ///
  String? condition;

  /// Custom user-visible information applied to this sale item.
  ///
  List<({String label, String description})>? informationList;

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
    fromJson: GsaModelSaleItem._originDataFromJson,
    toJson: GsaModelSaleItem._originDataToJson,
  )
  dynamic originData;

  // ignore: public_member_api_docs
  factory GsaModelSaleItem.fromJson(Map json) {
    return _$GsaModelSaleItemFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelSaleItemToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelSaleItem.mock({
    String? categoryId,
  }) {
    return GsaModelSaleItem(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      categoryId: categoryId,
      name: _Model._generateRandomString(20),
      amount: _Model._generateRandomNumber(1),
      measure: _Model._generateRandomString(4),
      description: _Model._generateRandomString(300),
      disclaimer: null,
      thumbnailUrls: ['https://picsum.photos/${200 + Random().nextInt(100)}/${300 + Random().nextInt(100)}'],
      imageUrls: ['https://picsum.photos/${1000 + Random().nextInt(100)}/${1600 + Random().nextInt(100)}'],
      attributeIconUrls: ['https://picsum.photos/${1000 + Random().nextInt(100)}/${1600 + Random().nextInt(100)}'],
      price: GsaModelPrice.mock(),
      availability: [],
      maxCount: _Model._generateRandomNumber(2),
      featured: Random().nextBool(),
      delivered: Random().nextBool(),
      digital: Random().nextBool(),
      payable: Random().nextBool(),
      options: [],
      originUrl: 'https://wikipedia.org/',
    );
  }

  static GsaModelSaleItem? findById(
    String saleItemId,
  ) {
    return GsaDataSaleItems.instance.collection.firstWhereOrNull(
      (saleItem) {
        return saleItem.id == saleItemId;
      },
    );
  }
}
