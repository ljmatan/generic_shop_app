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
    for (final item in orderDraft.items) {
      if (item.cartCount != null) count += item.cartCount!;
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

  /// Fetches the current cart item count for a specific product.
  ///
  /// Returns null if the product has not been added to the cart.
  ///
  int? itemCount(GsaModelSaleItem product) {
    try {
      return orderDraft.items.firstWhere(
        (item) {
          return item.id == product.id;
        },
      ).cartCount;
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
    return totalPriceEur.toStringAsFixed(2) + ' ${GsaConfig.currency.code}';
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
  /// Returns the current item cart count.
  ///
  void addItem(GsaModelSaleItem saleItem) {
    // Check for existing items in the cart.
    final productItemCount = itemCount(saleItem);
    if (productItemCount == null) {
      // This item hasn't been previously added to the cart.
      orderDraft.items.add(saleItem);
    } else {
      // This product has already been added to the cart in amount less than 100.
      final cartItemIndex = orderDraft.items.indexWhere((item) => item.id == saleItem.id);
      orderDraft.items[cartItemIndex] = saleItem;
    }
    notifierCartUpdate.value = totalItemCount;
    notifyListeners();
  }

  /// Removes a sale item from the cart.
  ///
  void removeItem(GsaModelSaleItem product) {
    orderDraft.items.removeWhere((item) => item.id == product.id);
    notifierCartUpdate.value = totalItemCount;
    notifyListeners();
  }

  /// Increases the quantity of an item added to the cart.
  ///
  /// If the item has not previously been added to the cart, it will be added with this method.
  ///
  void increaseItemCount(GsaModelSaleItem product) {
    addItem(product);
    notifyListeners();
  }

  /// Decreases the quantity of an item added to the cart,
  /// or remove the product if the quantity is too low.
  ///
  void decreaseItemCount(GsaModelSaleItem saleItem) {
    final count = itemCount(saleItem) ?? 0;
    if (count < 2) {
      removeItem(saleItem);
    } else {
      final cartItemIndex = orderDraft.items.indexWhere((item) => item.id == saleItem.id);
      orderDraft.items[cartItemIndex] = saleItem;
    }
    notifierCartUpdate.value = totalItemCount;
    notifyListeners();
  }
}
