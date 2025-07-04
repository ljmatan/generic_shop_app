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
  List<
      ({
        String id,
        String? optionId,
        int count,
      })> itemCount;

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

extension GsaModelOrderDraftInfoExt on GsaModelOrderDraft {
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

  /// Total number of all sale items in the cart.
  ///
  int get totalItemCount {
    int count = 0;
    for (final itemCountEntry in itemCount) {
      count += itemCountEntry.count;
    }
    return count;
  }

  /// Calculates and returns the combined price of the specified [saleItem].
  ///
  /// Returns null if the item price entries are not found.
  ///
  int? getItemTotalPriceCentum(
    GsaModelSaleItem saleItem,
  ) {
    final itemSaleOptions = [
      saleItem,
      if (saleItem.options != null) ...saleItem.options!,
    ];
    int? price;
    for (final saleOption in itemSaleOptions.indexed) {
      final priceCentum = saleOption.$2.price?.centum;
      if (priceCentum != null) {
        int? count;
        if (saleOption.$1 == 0) {
          count = getItemCount(saleOption.$2);
        } else {
          count = getItemOptionCount(saleOption.$2);
        }
        if (count != null) {
          price ??= 0;
          price += priceCentum * count;
        }
      }
    }
    return price;
  }

  /// Calculates and returns the combined price of the specified [saleItemOption].
  ///
  /// Returns null if the item option price is not found.
  ///
  int? getItemOptionTotalPriceCentum(
    GsaModelSaleItem saleItemOption,
  ) {
    final optionCount = getItemOptionCount(saleItemOption);
    if (optionCount == null || saleItemOption.price?.centum == null) {
      return null;
    }
    final value = optionCount * saleItemOption.price!.centum!;
    return value;
  }

  /// Calculates and returns the combined price of the specified [saleItem].
  ///
  /// Returns null if the calculated item price is not found.
  ///
  double? getItemTotalPriceUnity(
    GsaModelSaleItem saleItem,
  ) {
    final priceCentum = getItemTotalPriceCentum(saleItem);
    if (priceCentum == null) return null;
    final value = priceCentum / 100;
    return value;
  }

  /// Calculates and returns the combined price of the specified [saleItem].
  ///
  /// Returns null if the calculated item price is not found.
  ///
  double? getItemOptionTotalPriceUnity(
    GsaModelSaleItem saleItem,
  ) {
    final priceCentum = getItemOptionTotalPriceCentum(saleItem);
    if (priceCentum == null) return null;
    final value = priceCentum / 100;
    return value;
  }

  /// Total combined items price in centum.'
  ///
  /// Returns null if no price information is found.
  ///
  int? get totalItemPriceCentum {
    int? price;
    for (final saleItem in items) {
      final itemPrice = getItemTotalPriceCentum(saleItem);
      if (itemPrice != null) {
        price ??= 0;
        price += itemPrice;
      }
    }
    return price;
  }

  /// Total cart price in EUR cents.'
  ///
  int? get totalPriceCentum {
    int? price = totalItemPriceCentum;
    if (price == null) return null;
    price += deliveryType?.price?.centum ?? 0;
    price += paymentType?.price?.centum ?? 0;
    return price;
  }

  /// Total cart price in EUR.'
  ///
  double? get totalItemPriceUnity {
    final price = totalItemPriceCentum;
    if (price == null) return null;
    return double.parse((price / 100).toStringAsFixed(2));
  }

  /// Total cart price in EUR.'
  ///
  double? get totalPriceUnity {
    final price = totalPriceCentum;
    if (price == null) return null;
    return double.parse((price / 100).toStringAsFixed(2));
  }

  /// User-visible price representation.
  ///
  String get totalItemPriceFormatted {
    return GsaModelPrice(
          centum: totalItemPriceCentum,
        ).formatted ??
        'N/A';
  }

  /// User-visible price representation.
  ///
  String get totalPriceFormatted {
    return GsaModelPrice(
          centum: totalPriceCentum,
        ).formatted ??
        'N/A';
  }

  /// Fetches the current cart item count for a specific sale item.
  ///
  /// Returns null if the sale item has not been added to the cart.
  ///
  int? getItemCount(
    GsaModelSaleItem saleItem,
  ) {
    return itemCount.firstWhereOrNull(
      (item) {
        return item.optionId == null && item.id == saleItem.id;
      },
    )?.count;
  }

  /// Fetches the current cart item count for a specific sale item option.
  ///
  /// Returns null if no such option has been added to the cart.
  ///
  int? getItemOptionCount(
    GsaModelSaleItem saleItemOption,
  ) {
    return itemCount.firstWhereOrNull(
      (item) {
        return item.optionId != null && item.optionId == saleItemOption.id;
      },
    )?.count;
  }

  /// Fetches the current cart item count for relevant sale item options.
  ///
  /// Returns null if no such sale item option has been added to the cart.
  ///
  int? getItemOptionsCount(
    GsaModelSaleItem saleItem,
  ) {
    final optionsCounts = itemCount.where(
      (item) {
        return item.optionId != null && item.id == saleItem.id;
      },
    );
    if (optionsCounts.isEmpty) {
      return null;
    } else {
      int optionCount = 0;
      for (final option in optionsCounts) {
        optionCount += option.count;
      }
      return optionCount;
    }
  }

  /// Returns the total number of item and options added to the cart.
  ///
  int? getTotalItemCount(
    GsaModelSaleItem saleItem,
  ) {
    final itemCount = getItemCount(saleItem);
    final itemOptionsCount = getItemOptionsCount(saleItem);
    if (itemCount == null && itemOptionsCount == null) return null;
    return (itemCount ?? 0) + (itemOptionsCount ?? 0);
  }
}

extension GsaModelOrderDraftOperationsExt on GsaModelOrderDraft {
  /// Adds a sale item to the cart.
  ///
  /// Returns the current item cart count.
  ///
  void addItem({
    required GsaModelSaleItem saleItem,
    int? newCount,
  }) {
    if (saleItem.id == null) {
      throw Exception(
        'Sale item ID is missing - can\'t add.',
      );
    }
    if (newCount != null) {
      if (newCount < 1 && saleItem.allowZeroCartCount != true) {
        throw Exception('New count must not be less than 1.');
      }
      if (saleItem.maxCount != null && newCount > saleItem.maxCount!) {
        throw Exception(
          'Amount $newCount larger than max count ${saleItem.maxCount}.',
        );
      }
    }
    // Check for existing items in the cart.
    final saleItemCount = getItemCount(saleItem);
    if (saleItemCount == null) {
      // This item hasn't been previously added to the cart.
      if (items.where(
        (item) {
          return item.id != null && item.id == saleItem.id;
        },
      ).isEmpty) {
        items.add(saleItem);
      }
      itemCount.add(
        (
          id: saleItem.id!,
          optionId: null,
          count: newCount ?? 1,
        ),
      );
    } else {
      final cartItemIndex = itemCount.indexWhere(
        (item) {
          return item.optionId == null && item.id == saleItem.id;
        },
      );
      if (cartItemIndex == -1) {
        throw Exception(
          'Can\'t find item index to add.',
        );
      }
      final currentCount = itemCount[cartItemIndex].count;
      final updatedCount = newCount ?? (currentCount + 1);
      if (saleItem.maxCount != null && updatedCount > saleItem.maxCount!) {
        throw Exception(
          'Amount $updatedCount larger than max count ${saleItem.maxCount}.',
        );
      }
      itemCount[cartItemIndex] = (
        id: saleItem.id!,
        optionId: null,
        count: updatedCount,
      );
    }
    GsaDataCheckout.instance.notifyListeners();
  }

  /// Validates the [saleItem] and [optionIndex] values.
  ///
  /// Returns the option selection object.
  ///
  GsaModelSaleItem _verifyItemOptionInput({
    required GsaModelSaleItem saleItem,
    required int optionIndex,
  }) {
    if (saleItem.id == null) {
      throw Exception(
        'Sale item ID is missing - can\'t add option.',
      );
    }
    if (saleItem.options?.isNotEmpty != true) {
      throw Exception(
        'Sale item options missing - can\'t add option.',
      );
    }
    if (optionIndex == -1) {
      throw Exception(
        'Option index unreachable - can\'t add option.',
      );
    }
    final option = saleItem.options!.elementAtOrNull(optionIndex);
    if (option == null) {
      throw Exception(
        'Sale item option is missing - can\'t add option.',
      );
    }
    if (option.id == null) {
      throw Exception(
        'Sale item option ID is missing - can\'t add option.',
      );
    }
    return option;
  }

  /// Adds a specified [saleItem] option entry with [optionIndex] into the order draft.
  ///
  void addItemOption({
    required GsaModelSaleItem saleItem,
    required int optionIndex,
    int? newCount,
  }) {
    final saleItemOption = _verifyItemOptionInput(
      saleItem: saleItem,
      optionIndex: optionIndex,
    );
    if (newCount != null) {
      if (newCount < 1 && saleItemOption.allowZeroCartCount != true) {
        throw Exception('New count must not be less than 1.');
      }
      if (saleItemOption.maxCount != null && newCount > saleItemOption.maxCount!) {
        throw Exception(
          'Amount $newCount larger than max count ${saleItemOption.maxCount}.',
        );
      }
    }
    // Check for existing items in the cart.
    final saleItemOptionCount = getItemOptionCount(saleItemOption);
    if (saleItemOptionCount == null) {
      // Item option has not yet been added to the cart.
      if (items.where(
        (item) {
          return item.id != null && item.id == saleItem.id;
        },
      ).isEmpty) {
        items.add(saleItem);
      }
      itemCount.add(
        (
          id: saleItem.id!,
          optionId: saleItemOption.id!,
          count: newCount ?? 1,
        ),
      );
    } else {
      // Item option has been added to the cart.
      final cartItemIndex = itemCount.indexWhere(
        (item) {
          return item.optionId != null && item.optionId == saleItemOption.id;
        },
      );
      if (cartItemIndex == -1) {
        throw Exception(
          'Can\'t find item option index to add.',
        );
      }
      final currentCount = itemCount[cartItemIndex].count;
      final updatedCount = newCount ?? (currentCount + 1);
      if (saleItemOption.maxCount != null && updatedCount > saleItemOption.maxCount!) {
        throw Exception(
          'Amount $updatedCount larger than max count ${saleItemOption.maxCount}.',
        );
      }
      itemCount[cartItemIndex] = (
        id: saleItem.id!,
        optionId: saleItemOption.id!,
        count: updatedCount,
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

  /// Removes a sale item option from the cart.
  ///
  void removeItemOption({
    required GsaModelSaleItem saleItem,
    required int optionIndex,
  }) {
    final saleItemOption = _verifyItemOptionInput(
      saleItem: saleItem,
      optionIndex: optionIndex,
    );
    itemCount.removeWhere(
      (item) {
        return item.optionId != null && item.optionId == saleItemOption.id;
      },
    );
    if (saleItem.allowZeroCartCount != true) {
      final saleItemCount = getTotalItemCount(saleItem);
      if (saleItemCount == null) {
        items.removeWhere(
          (item) {
            return item.id == saleItem.id;
          },
        );
      }
    }
    GsaDataCheckout.instance.notifyListeners();
  }

  /// Increases the quantity of an item added to the cart.
  ///
  /// If the item has not previously been added to the cart,
  /// it will be added with this method.
  ///
  void increaseItemCount(GsaModelSaleItem item) {
    addItem(saleItem: item);
  }

  /// Increases the quantity of an item option added to the cart.
  ///
  /// If the item option has not previously been added to the cart,
  /// it will be added with this method.
  ///
  void increaseItemOptionCount({
    required GsaModelSaleItem saleItem,
    required int optionIndex,
  }) {
    addItemOption(
      saleItem: saleItem,
      optionIndex: optionIndex,
    );
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
      if (cartItemIndex == -1) {
        throw Exception(
          'Can\'t find item index to decrease.',
        );
      }
      final currentCount = itemCount[cartItemIndex].count;
      itemCount[cartItemIndex] = (
        id: saleItem.id!,
        optionId: null,
        count: currentCount - 1,
      );
      GsaDataCheckout.instance.notifyListeners();
    }
  }

  /// Decreases the quantity of an item option added to the cart,
  /// or remove the sale item option if the quantity is too low.
  ///
  void decreaseItemOptionCount({
    required GsaModelSaleItem saleItem,
    required int optionIndex,
  }) {
    final saleItemOption = _verifyItemOptionInput(
      saleItem: saleItem,
      optionIndex: optionIndex,
    );
    final count = getItemOptionCount(saleItemOption) ?? 0;
    if (count < 2) {
      removeItemOption(
        saleItem: saleItem,
        optionIndex: optionIndex,
      );
    } else {
      final cartItemIndex = itemCount.indexWhere(
        (item) {
          return item.optionId != null && item.optionId == saleItemOption.id;
        },
      );
      if (cartItemIndex == -1) {
        throw Exception(
          'Can\'t find item option index to decrease.',
        );
      }
      final currentCount = itemCount[cartItemIndex].count;
      itemCount[cartItemIndex] = (
        id: saleItem.id!,
        optionId: saleItemOption.id!,
        count: currentCount - 1,
      );
      GsaDataCheckout.instance.notifyListeners();
    }
  }

  /// Specifies the [saleItem] cart count with [newCount].
  ///
  /// If no valid count is provided, the item is removed.
  ///
  void updateItemCount({
    required GsaModelSaleItem saleItem,
    required int newCount,
  }) {
    if (newCount < 1) {
      removeItem(saleItem);
    } else {
      addItem(
        saleItem: saleItem,
        newCount: newCount,
      );
    }
  }

  /// Specifies the [saleItem] option cart count with [newCount].
  ///
  /// If no valid count is provided, the item is removed.
  ///
  void updateItemOptionCount({
    required GsaModelSaleItem saleItem,
    required int optionIndex,
    required int newCount,
  }) {
    if (newCount < 1) {
      removeItemOption(
        saleItem: saleItem,
        optionIndex: optionIndex,
      );
    } else {
      addItemOption(
        saleItem: saleItem,
        optionIndex: optionIndex,
        newCount: newCount,
      );
    }
  }

  /// Returs a list of sale item options added to the cart.
  ///
  List<GsaModelSaleItem> getCartSaleItemOptions(
    GsaModelSaleItem saleItem,
  ) {
    if (saleItem.options?.isNotEmpty != true) {
      throw Exception(
        'No sale item options defined for ${saleItem.id}.',
      );
    }
    final matchingOptions = itemCount.where(
      (itemCountEntry) {
        return itemCountEntry.id == saleItem.id;
      },
    );
    return saleItem.options!.where(
      (option) {
        return matchingOptions.where(
          (matchingOption) {
            return matchingOption.optionId != null && matchingOption.optionId == option.id;
          },
        ).isNotEmpty;
      },
    ).toList();
  }

  /// Sale items can be optionally added to the cart with amount equaling 0,
  /// where only their specified [options] can then be purchased.
  ///
  /// When such an item has been added but not confirmed with any option input,
  /// the entries are cleared from the list of relevant [items] their [itemCount].
  ///
  void _removeEmptyEntries() {
    items.removeWhere(
      (item) {
        return item.cartCountWithOptions(orderDraft: this) == null;
      },
    );
    itemCount.removeWhere(
      (itemCount) {
        return items.where(
          (item) {
            return item.id == itemCount.id;
          },
        ).isEmpty;
      },
    );
    GsaDataCheckout.instance.notifyListeners();
  }

  /// Clears the order by removing all of the items and personal details from the order draft.
  ///
  void clear() {
    _removeEmptyEntries();
    items.clear();
    itemCount.clear();
    client = null;
    deliveryType = null;
    paymentType = null;
    couponCode = null;
    price = null;
  }
}
