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
    this.option,
    this.allowZeroCartCount,
    this.options,
    this.reviews,
    this.deliveryTimeMilliseconds,
    this.condition,
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

  /// Availability information, including store location identifier or available item count.
  ///
  List<
      ({
        String? locationId,
        int? count,
      })>? availability;

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

  /// Whether the sale item is defined as a sale item option.
  ///
  bool? option;

  /// Whether the item can be added to the cart with amount specified as 0.
  ///
  /// The value is utilised by the [GsaModelOrderDraft] object
  /// in order to implement additional functionality.
  ///
  bool? allowZeroCartCount;

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
  List<
      ({
        String label,
        String description,
      })>? informationList;

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

  GsaModelSaleItem copyWith({
    String? id,
    String? originId,
    String? categoryId,
    String? name,
    String? productCode,
    num? amount,
    String? measure,
    String? description,
    String? disclaimer,
    List<String>? imageUrls,
    List<String>? thumbnailUrls,
    List<String>? attributeIconUrls,
    GsaModelPrice? price,
    List<({String? locationId, int? count})>? availability,
    int? maxCount,
    bool? featured,
    bool? delivered,
    bool? digital,
    bool? payable,
    bool? option,
    bool? allowZeroCartCount,
    List<GsaModelSaleItem>? options,
    List<GsaModelReview>? reviews,
    int? deliveryTimeMilliseconds,
    String? condition,
    List<({String label, String description})>? informationList,
    dynamic originData,
    String? originUrl,
    List<String>? consentIds,
    List<String>? tags,
  }) {
    return GsaModelSaleItem(
      id: id ?? this.id,
      originId: originId ?? this.originId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      productCode: productCode ?? this.productCode,
      amount: amount ?? this.amount,
      measure: measure ?? this.measure,
      description: description ?? this.description,
      disclaimer: disclaimer ?? this.disclaimer,
      imageUrls: imageUrls ?? this.imageUrls,
      thumbnailUrls: thumbnailUrls ?? this.thumbnailUrls,
      attributeIconUrls: attributeIconUrls ?? this.attributeIconUrls,
      price: price ?? this.price,
      availability: availability ?? this.availability,
      maxCount: maxCount ?? this.maxCount,
      featured: featured ?? this.featured,
      delivered: delivered ?? this.delivered,
      digital: digital ?? this.digital,
      payable: payable ?? this.payable,
      option: option ?? this.option,
      allowZeroCartCount: allowZeroCartCount ?? this.allowZeroCartCount,
      options: options ?? this.options,
      reviews: reviews ?? this.reviews,
      deliveryTimeMilliseconds: deliveryTimeMilliseconds ?? this.deliveryTimeMilliseconds,
      condition: condition ?? this.condition,
      informationList: informationList ?? this.informationList,
      originData: originData ?? this.originData,
      originUrl: originUrl ?? this.originUrl,
      consentIds: consentIds ?? this.consentIds,
      tags: tags ?? this.tags,
    );
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
}

/// Extension methods for the [GsaModelSaleItem] model class.
///
extension GsaModelSaleItemExt on GsaModelSaleItem {
  /// The amount of the current item in the cart or order draft.
  ///
  int? cartCount({
    GsaModelOrderDraft? orderDraft,
  }) {
    orderDraft ??= GsaDataCheckout.instance.orderDraft;
    if (option == true) {
      return orderDraft.getItemOptionCount(this);
    } else {
      return orderDraft.getItemCount(this);
    }
  }

  /// Returns the amount of the current item in the cart,
  /// alongside the amount of any specified options.
  ///
  /// Returns null if no count is specified for any of the items.
  ///
  int? cartCountWithOptions({
    GsaModelOrderDraft? orderDraft,
  }) {
    orderDraft ??= GsaDataCheckout.instance.orderDraft;
    int? count;
    if (option == true) {
      return null;
    }
    final itemCount = orderDraft.getItemCount(this);
    if (itemCount != null && itemCount > 0) {
      count ??= 0;
      count += itemCount;
    }
    if (options?.isNotEmpty == true) {
      for (final saleItemOption in options!) {
        final optionCount = orderDraft.getItemOptionCount(saleItemOption);
        if (optionCount != null && optionCount > 0) {
          count ??= 0;
          count += optionCount;
        }
      }
    }
    return count;
  }

  /// The set [price] amount for the specified [cartCount] within the [orderDraft].
  ///
  int? totalCartPriceCentum({
    GsaModelOrderDraft? orderDraft,
  }) {
    orderDraft ??= GsaDataCheckout.instance.orderDraft;
    if (option == true) {
      return orderDraft.getItemOptionTotalPriceCentum(this);
    } else {
      return orderDraft.getItemTotalPriceCentum(this);
    }
  }

  /// The set [price] amount for the specified [cartCount] within the [orderDraft].
  ///
  double? totalCartPriceUnity({
    GsaModelOrderDraft? orderDraft,
  }) {
    orderDraft ??= GsaDataCheckout.instance.orderDraft;
    if (option == true) {
      return orderDraft.getItemOptionTotalPriceUnity(this);
    } else {
      return orderDraft.getItemTotalPriceUnity(this);
    }
  }

  /// Formatted display of the total cart price for this sale item.
  ///
  String? totalCartPriceFormatted({
    GsaModelOrderDraft? orderDraft,
  }) {
    orderDraft ??= GsaDataCheckout.instance.orderDraft;
    final price = totalCartPriceCentum(orderDraft: orderDraft);
    if (price == null) return null;
    return GsaModelPrice(
          centum: price,
        ).formatted ??
        'N/A';
  }

  /// Returns the price value for the cheapest of available [options].
  ///
  /// Returns null if no options with defined price exist.
  ///
  int? startingOptionPriceCentum({
    GsaModelOrderDraft? orderDraft,
  }) {
    orderDraft ??= GsaDataCheckout.instance.orderDraft;
    if (options?.any(
          (option) {
            return option.price?.centum != null;
          },
        ) !=
        true) {
      return null;
    }
    final sortedOptions = List<GsaModelSaleItem>.from(options ?? [])
      ..sort(
        (a, b) => (a.price?.centum ?? double.infinity).compareTo(
          b.price?.centum ?? double.infinity,
        ),
      );
    sortedOptions.removeWhere(
      (option) {
        return option.price?.centum == null;
      },
    );
    return sortedOptions.first.price?.centum;
  }

  /// Returns the formatted display of the cheapest available sale item option.
  ///
  /// Returns null if there is no option with a price defined available.
  ///
  String? startingOptionPriceFormatted({
    GsaModelOrderDraft? orderDraft,
  }) {
    orderDraft ??= GsaDataCheckout.instance.orderDraft;
    final price = startingOptionPriceCentum(orderDraft: orderDraft);
    if (price == null) return null;
    return 'From ${GsaModelPrice(centum: price).formatted}';
  }

  /// Whether this sale item is defined with a price.
  ///
  bool get itemPriceExists {
    return price != null;
  }

  /// Whether any of the sale item options are defined with a price.
  ///
  bool get itemOptionPriceExists {
    return options?.where(
          (saleItemOption) {
            return saleItemOption.price != null;
          },
        ).isNotEmpty ==
        true;
  }
}
