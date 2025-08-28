import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Data class implementing the merchant / vendor methods and properties.
///
class GsaDataSaleItems extends GsaData {
  GsaDataSaleItems._();

  /// Globally-accessible singleton class instance.
  ///
  static final instance = GsaDataSaleItems._();

  /// List of available sale item categories.
  ///
  List<GsaModelCategory> categories = [];

  /// Display products fetched for the given runtime.
  ///
  List<GsaModelSaleItem> collection = [];

  /// Provided item delivery options.
  ///
  List<GsaModelSaleItem> deliveryOptions = [];

  /// Provided item payment options.
  ///
  List<GsaModelSaleItem> paymentOptions = [];

  @override
  Future<void> clear() async {
    collection.clear();
    categories.clear();
  }

  @override
  Future<void> init({
    List<GsaModelCategory>? categories,
    List<GsaModelSaleItem>? saleItems,
    List<GsaModelSaleItem>? deliveryOptions,
    List<GsaModelSaleItem>? paymentOptions,
  }) async {
    await clear();
    if (categories != null) instance.categories.addAll(categories);
    if (saleItems != null) instance.collection.addAll(saleItems);
    if (deliveryOptions != null) instance.deliveryOptions.addAll(deliveryOptions);
    if (paymentOptions != null) instance.paymentOptions.addAll(paymentOptions);
  }
}
