part of '../models.dart';

/// Object representing any sale item such as products, delivery services, etc.
///
@JsonSerializable(explicitToJson: true)
class GsaaModelSaleItem extends _Model {
  // ignore: public_member_api_docs
  GsaaModelSaleItem({
    super.id,
    super.originId,
    super.categoryId,
    this.name,
    this.amount,
    this.measure,
    this.descriptionShort,
    this.descriptionLong,
    this.disclaimer,
    this.thumbnailUrl,
    this.imageUrl,
    this.price,
    this.cartCount,
    this.availableCount,
    this.maxCount,
    this.featured,
    this.delivered,
    this.digital,
    this.payable,
    this.options,
    this.reviews,
    this.deliveryTimeMilliseconds,
    this.informationList,
    super.originUrl,
    super.consentIds,
  });

  /// Item display name.
  ///
  String? name;
  // GsaaModelTranslated? name;

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
  String? descriptionShort, descriptionLong;

  /// Product disclaimer, usually representing a legally-required notice.
  ///
  String? disclaimer;

  /// Item graphical representation.
  ///
  String? thumbnailUrl, imageUrl;

  /// Price associated with the item.
  ///
  GsaaModelPrice? price;

  /// The amount of the current item in the cart or order draft.
  ///
  int? cartCount;

  /// The number of available items for sale.
  ///
  int? availableCount;

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

  /// List of associated [GsaaModelSaleItemOption] objects.
  ///
  List<GsaaModelSaleItem>? options;

  /// List of available reviews for this sale item.
  ///
  List<GsaaModelReview>? reviews;

  /// Delivery time for the sale item in milliseconds.
  ///
  int? deliveryTimeMilliseconds;

  /// Item condition (new, used, refurbished, etc.).
  ///
  String? condition;

  /// Custom user-visible information applied to this sale item.
  ///
  List<({String label, String description})>? informationList;

  // ignore: public_member_api_docs
  factory GsaaModelSaleItem.fromJson(Map json) {
    return _$GsaaModelSaleItemFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelSaleItemToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaaModelSaleItem.mock({
    String? categoryId,
  }) {
    return GsaaModelSaleItem(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      categoryId: categoryId,
      name: _Model._generateRandomString(20),
      amount: _Model._generateRandomNumber(1),
      measure: _Model._generateRandomString(4),
      descriptionLong: _Model._generateRandomString(300),
      descriptionShort: _Model._generateRandomString(40),
      disclaimer: null,
      thumbnailUrl: 'https://picsum.photos/${200 + Random().nextInt(100)}/${300 + Random().nextInt(100)}',
      imageUrl: 'https://picsum.photos/${1000 + Random().nextInt(100)}/${1600 + Random().nextInt(100)}',
      price: GsaaModelPrice.mock(),
      availableCount: _Model._generateRandomNumber(2),
      maxCount: _Model._generateRandomNumber(2),
      featured: Random().nextBool(),
      delivered: Random().nextBool(),
      digital: Random().nextBool(),
      payable: Random().nextBool(),
      options: [],
      originUrl: 'https://wikipedia.org/',
    );
  }
}
