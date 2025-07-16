import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_api/api.dart';
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

  /// Notifies listeners of any changes to the cart items with total count number.
  ///
  final notifierCartUpdate = ValueNotifier<int>(0);

  @override
  void notifyListeners() {
    notifierCartUpdate.value = orderDraft.totalItemCount ?? 0;
    super.notifyListeners();
  }
}
