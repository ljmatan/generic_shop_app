part of '../models.dart';

/// Model class specifying the parameters for the checkout process.
///
@JsonSerializable(explicitToJson: true)
class GsaModelOrderDraft extends _Model {
  // ignore: public_member_api_docs
  GsaModelOrderDraft({
    super.id,
    super.originId,
    required this.items,
    this.client,
    this.deliveryType,
    this.paymentType,
    this.couponCode,
    this.price,
  }) : itemCount = [];

  /// List of products in the order.
  ///
  List<GsaModelSaleItem> items;

  /// Collection of recorded item identifiers and their respective cart count.
  ///
  List<({String id, int count})> itemCount;

  /// Client specified for this checkout order.
  ///
  GsaModelClient? client;

  /// Delivery and invoice addresses specified for the order.
  ///
  GsaModelAddress? deliveryAddress, invoiceAddress;

  /// The type of delivery option specified for the order.
  ///
  GsaModelSaleItem? deliveryType;

  /// Payment type specified for the order.
  ///
  GsaModelSaleItem? paymentType;

  /// The specified merchant / executor for this order.
  ///
  GsaModelMerchant? orderProcessor;

  /// Coupon code applied to this order.
  ///
  String? couponCode;

  /// Total cart price, including any discount or promo info.
  ///
  GsaModelPrice? price;

  /// Total number of all sale items in the cart.
  ///
  int get totalItemCount {
    int count = 0;
    for (final cartItem in items) {
      final itemCount = cartItem.cartCount();
      if (itemCount != null) count += itemCount;
      if (cartItem.options?.isNotEmpty == true) {
        for (final option in cartItem.options!) {
          final optionCount = option.cartCount();
          if (optionCount != null) count += optionCount;
        }
      }
    }
    return count;
  }

  /// Total combined items price in EUR cents.'
  ///
  int get totalItemPriceEurCents {
    int price = 0;
    for (final cartItem in items) {
      if (cartItem.price?.centum != null) {
        final count = getItemCount(cartItem);
        if (count != null) {
          price += count * cartItem.price!.centum!;
        }
      }
    }
    return price;
  }

  /// Total cart price in EUR cents.'
  ///
  int get totalPriceEurCents {
    int price = totalItemPriceEurCents;
    price += deliveryType?.price?.centum ?? 0;
    price += paymentType?.price?.centum ?? 0;
    return price;
  }

  /// Total cart price in EUR.'
  ///
  double get totalItemPriceEur {
    return double.parse((totalPriceEurCents / 100).toStringAsFixed(2));
  }

  /// User-visible price representation.
  ///
  String get totalItemPriceFormatted {
    return totalPriceEur.toStringAsFixed(2) + ' ${GsaConfig.currency.code}';
  }

  /// Total cart price in EUR.'
  ///
  double get totalPriceEur {
    return double.parse((totalPriceEurCents / 100).toStringAsFixed(2));
  }

  /// User-visible price representation.
  ///
  String get totalPriceFormatted {
    return totalPriceEur.toStringAsFixed(2) + ' ${GsaConfig.currency.code}';
  }

  /// Whether this order is deliverable with the current configuration.
  ///
  bool get deliverable {
    return items.every(
      (cartItem) {
        return cartItem.delivered != false;
      },
    );
  }

  /// Whether this order is payable with the current configuration.
  ///
  bool get payable {
    return items.every(
          (cartItem) {
            return cartItem.payable != false;
          },
        ) &&
        deliveryType?.payable != false;
  }

  /// Fetches the current cart item count for a specific sale item.
  ///
  /// Returns null if the sale item has not been added to the cart.
  ///
  int? getItemCount(
    GsaModelSaleItem saleItem,
  ) {
    try {
      return itemCount.firstWhere(
        (item) {
          return item.id == saleItem.id;
        },
      ).count;
    } catch (e) {
      return null;
    }
  }

  /// Calculates and returns the combined price of the specified [saleItem].
  ///
  /// Returns null if the item doesn't have a price, and returns 0 if count is not recorded.
  ///
  int? getItemTotalPriceCentum(
    GsaModelSaleItem saleItem,
  ) {
    if (saleItem.price?.centum == null) return null;
    final count = getItemCount(saleItem) ?? 0;
    return count * saleItem.price!.centum!;
  }

  /// Calculates and returns the combined price of the specified [saleItem].
  ///
  /// Returns null if the item doesn't have a price, and returns 0 if count is not recorded.
  ///
  double? getItemTotalPriceUnity(
    GsaModelSaleItem saleItem,
  ) {
    if (saleItem.price?.unity == null) return null;
    final count = getItemCount(saleItem) ?? 0;
    return count * saleItem.price!.unity!;
  }

  /// Adds a sale item to the cart.
  ///
  /// Returns the current item cart count.
  ///
  void addItem(GsaModelSaleItem saleItem) {
    if (saleItem.id == null) {
      throw Exception(
        'Sale item ID is missing - can\'t add.',
      );
    }
    // Check for existing items in the cart.
    final saleItemCount = getItemCount(saleItem);
    if (saleItemCount == null) {
      // This item hasn't been previously added to the cart.
      items.add(saleItem);
      itemCount.add(
        (
          id: saleItem.id!,
          count: 1,
        ),
      );
    } else {
      final cartItemIndex = itemCount.indexWhere(
        (item) {
          return item.id == saleItem.id;
        },
      );
      final currentCount = itemCount[cartItemIndex].count;
      itemCount[cartItemIndex] = (
        id: saleItem.id!,
        count: currentCount + 1,
      );
    }
    GsaDataCheckout.instance.notifyListeners();
  }

  /// Removes a sale item from the cart.
  ///
  void removeItem(GsaModelSaleItem saleItem) {
    if (saleItem.id == null) {
      throw Exception(
        'Sale item ID is missing - can\'t remove.',
      );
    }
    items.removeWhere(
      (item) {
        return item.id == saleItem.id;
      },
    );
    itemCount.removeWhere(
      (item) {
        return item.id == saleItem.id;
      },
    );
    GsaDataCheckout.instance.notifyListeners();
  }

  /// Increases the quantity of an item added to the cart.
  ///
  /// If the item has not previously been added to the cart, it will be added with this method.
  ///
  void increaseItemCount(GsaModelSaleItem item) {
    addItem(item);
  }

  /// Decreases the quantity of an item added to the cart,
  /// or remove the sale item if the quantity is too low.
  ///
  void decreaseItemCount(GsaModelSaleItem saleItem) {
    final count = getItemCount(saleItem) ?? 0;
    if (count < 2) {
      removeItem(saleItem);
    } else {
      final cartItemIndex = itemCount.indexWhere(
        (item) {
          return item.id == saleItem.id;
        },
      );
      final currentCount = itemCount[cartItemIndex].count;
      itemCount[cartItemIndex] = (
        id: saleItem.id!,
        count: currentCount - 1,
      );
      GsaDataCheckout.instance.notifyListeners();
    }
  }

  /// Clears the order by removing all of the items and personal details from the order draft.
  ///
  void clear() {
    items.clear();
    itemCount.clear();
    client = null;
    deliveryType = null;
    paymentType = null;
    couponCode = null;
    price = null;
  }

  // ignore: public_member_api_docs
  factory GsaModelOrderDraft.fromJson(Map json) {
    return _$GsaModelOrderDraftFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelOrderDraftToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelOrderDraft.mock() {
    return GsaModelOrderDraft(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      items: [],
      client: GsaModelClient.mock(),
      deliveryType: GsaModelSaleItem.mock(),
      couponCode: _Model._generateRandomString(8),
      paymentType: GsaModelSaleItem.mock(),
      price: null,
    );
  }
}
