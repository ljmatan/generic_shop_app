import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Data class implementing the checkout methods and properties.
///
class GsaDataCheckout extends GsaData {
  GsaDataCheckout._();

  /// Globally-accessible singleton class instance.
  ///
  static final instance = GsaDataCheckout._();

  /// Draft for the current order initiated by the user.
  ///
  GsaModelOrderDraft _orderDraft = GsaModelOrderDraft(
    items: [],
  );

  /// Getter method for the current order draft [_orderDraft] data.
  ///
  GsaModelOrderDraft get orderDraft {
    return _orderDraft;
  }

  /// Setter method for the current order draft [_orderDraft] data.
  ///
  set orderDraft(GsaModelOrderDraft value) {
    _orderDraft = value;
    notifyListeners();
  }

  @override
  Future<void> init() async {
    clear();
  }

  @override
  void clear() {
    orderDraft.clear();
    notifyListeners();
  }

  /// Total number of all sale items in the cart.
  ///
  int get totalItemCount {
    int count = 0;
    for (final cartItem in orderDraft.items) {
      final itemCount = cartItem.cartCount;
      if (itemCount != null) count += itemCount;
      if (cartItem.options?.isNotEmpty == true) {
        for (final option in cartItem.options!) {
          final optionCount = option.cartCount;
          if (optionCount != null) count += optionCount;
        }
      }
    }
    return count;
  }

  /// Notifies listeners of any changes to the cart items with total count number.
  ///
  final notifierCartUpdate = ValueNotifier<int>(0);

  @override
  void notifyListeners() {
    notifierCartUpdate.value = totalItemCount;
    super.notifyListeners();
  }

  /// Fetches the current cart item count for a specific sale item.
  ///
  /// Returns null if the sale item has not been added to the cart.
  ///
  int? itemCount(GsaModelSaleItem saleItem) {
    try {
      return orderDraft.itemCount.firstWhere(
        (item) {
          return item.id == saleItem.id;
        },
      ).count;
    } catch (e) {
      return null;
    }
  }

  /// Total combined items price in EUR cents.'
  ///
  int get totalItemPriceEurCents {
    int price = 0;
    for (final cartItem in orderDraft.items) {
      if (cartItem.price?.centum != null) {
        final count = itemCount(cartItem);
        if (count != null) {
          price += count * cartItem.price!.centum!;
        }
      }
    }
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

  /// Total cart price in EUR cents.'
  ///
  int get totalPriceEurCents {
    int price = totalItemPriceEurCents;
    price += orderDraft.deliveryType?.price?.centum ?? 0;
    price += orderDraft.paymentType?.price?.centum ?? 0;
    return price;
  }

  /// Total cart price in EUR.'
  ///
  double get totalPriceEur {
    return double.parse((totalPriceEurCents / 100).toStringAsFixed(2));
  }

  /// User-visible price representation.
  ///
  String get totalPriceFormatted {
    return totalPriceEur.toStringAsFixed(2);
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
    final saleItemCount = itemCount(saleItem);
    if (saleItemCount == null) {
      // This item hasn't been previously added to the cart.
      orderDraft.items.add(saleItem);
      orderDraft.itemCount.add(
        (
          id: saleItem.id!,
          count: 1,
        ),
      );
    } else {
      final cartItemIndex = orderDraft.itemCount.indexWhere(
        (item) {
          return item.id == saleItem.id;
        },
      );
      final currentCount = orderDraft.itemCount[cartItemIndex].count;
      orderDraft.itemCount[cartItemIndex] = (
        id: saleItem.id!,
        count: currentCount + 1,
      );
    }
    notifyListeners();
  }

  /// Removes a sale item from the cart.
  ///
  void removeItem(GsaModelSaleItem saleItem) {
    if (saleItem.id == null) {
      throw Exception(
        'Sale item ID is missing - can\'t remove.',
      );
    }
    orderDraft.items.removeWhere(
      (item) {
        return item.id == saleItem.id;
      },
    );
    orderDraft.itemCount.removeWhere(
      (item) {
        return item.id == saleItem.id;
      },
    );
    notifyListeners();
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
    final count = itemCount(saleItem) ?? 0;
    if (count < 2) {
      removeItem(saleItem);
    } else {
      final cartItemIndex = orderDraft.itemCount.indexWhere(
        (item) {
          return item.id == saleItem.id;
        },
      );
      final currentCount = orderDraft.itemCount[cartItemIndex].count;
      orderDraft.itemCount[cartItemIndex] = (
        id: saleItem.id!,
        count: currentCount - 1,
      );
      notifyListeners();
    }
  }
}
