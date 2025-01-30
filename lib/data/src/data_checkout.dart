import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Data class implementing the checkout methods and properties.
///
class GsaDataCheckout extends GsarData {
  GsaDataCheckout._();

  // ignore: public_member_api_docs
  static final instance = GsaDataCheckout._();

  /// Draft for the current order initiated by the user.
  ///
  final orderDraft = GsaaModelOrderDraft.mock();

  @override
  Future<void> init() async {
    clear();
  }

  @override
  void clear() {
    orderDraft.clear();
    onCartUpdate();
  }

  /// Total number of all sale items in the cart.
  ///
  int get totalItemCount {
    int count = 0;
    for (final item in orderDraft.items) {
      if (item.cartCount != null) count += item.cartCount!;
    }
    return count;
  }

  /// Notifies listeners of any changes to the cart items with total count number.
  ///
  final notifierCartUpdate = ValueNotifier<int>(0);

  /// Manually invoked on cart update to notify any listeners.
  ///
  void onCartUpdate() {
    notifierCartUpdate.value = totalItemCount;
  }

  /// Fetches the current cart item count for a specific product.
  ///
  /// Returns null if the product has not been added to the cart.
  ///
  int? itemCount(GsaaModelSaleItem product) {
    try {
      return orderDraft.items.firstWhere((item) => item.id == product.id).cartCount;
    } catch (e) {
      return null;
    }
  }

  /// Total combined items price in EUR cents.'
  ///
  int get totalItemPriceEurCents {
    int price = 0;
    for (final item in orderDraft.items) {
      if (item.price?.centum != null) {
        price += (item.cartCount ?? 0) * item.price!.centum!;
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
    return totalPriceEur.toStringAsFixed(2);
  }

  /// Total cart price in EUR cents.'
  ///
  int get totalPriceEurCents {
    int price = 0;
    for (final item in orderDraft.items) {
      if (item.price?.centum != null) {
        price += (item.cartCount ?? 0) * item.price!.centum!;
      }
    }
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
  void addItem(GsaaModelSaleItem saleItem) {
    // Check for existing items in the cart.
    final productItemCount = itemCount(saleItem);
    if (productItemCount == null) {
      // This item hasn't been previously added to the cart.
      orderDraft.items.add(saleItem..cartCount = 1);
    } else if (productItemCount < 100000) {
      // This product has already been added to the cart in amount less than 100.
      final cartItemIndex = orderDraft.items.indexWhere((item) => item.id == saleItem.id);
      saleItem.cartCount = saleItem.cartCount! + 1;
      orderDraft.items[cartItemIndex] = saleItem;
    } else {
      throw 'Error.';
    }
    notifierCartUpdate.value = totalItemCount;
  }

  /// Removes a sale item from the cart.
  ///
  void removeItem(GsaaModelSaleItem product) {
    orderDraft.items.removeWhere((item) => item.id == product.id);
    notifierCartUpdate.value = totalItemCount;
  }

  /// Increases the quantity of an item added to the cart.
  ///
  /// If the item has not previously been added to the cart, it will be added with this method.
  ///
  void increaseItemCount(GsaaModelSaleItem product) {
    addItem(product);
  }

  /// Decreases the quantity of an item added to the cart,
  /// or remove the product if the quantity is too low.
  ///
  void decreaseItemCount(GsaaModelSaleItem saleItem) {
    final count = itemCount(saleItem) ?? 0;
    if (count < 2) {
      removeItem(saleItem);
    } else {
      final cartItemIndex = orderDraft.items.indexWhere((item) => item.id == saleItem.id);
      orderDraft.items[cartItemIndex] = saleItem;
    }
    notifierCartUpdate.value = totalItemCount;
  }
}
