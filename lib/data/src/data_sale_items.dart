import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app_api/src/models/models.dart';

/// Data class implementing the merchant / vendor methods and properties.
///
class GsaDataSaleItems extends GsaData {
  GsaDataSaleItems._();

  // ignore: public_member_api_docs
  static final instance = GsaDataSaleItems._();

  /// List of available sale item categories.
  ///
  List<GsaaModelCategory> categories = [];

  /// Display products fetched for the given runtime.
  ///
  List<GsaaModelSaleItem> products = [];

  /// Provided item delivery options.
  ///
  List<GsaaModelSaleItem> deliveryOptions = [];

  /// Provided item payment options.
  ///
  List<GsaaModelSaleItem> paymentOptions = [];

  /// A list of featured products.
  ///
  List<GsaaModelSaleItem>? featured;

  @override
  void clear() {
    products.clear();
    featured?.clear();
    categories.clear();
  }

  @override
  Future<void> init({
    List<GsaaModelCategory>? categories,
    List<GsaaModelSaleItem>? saleItems,
    List<GsaaModelSaleItem>? deliveryOptions,
    List<GsaaModelSaleItem>? paymentOptions,
  }) async {
    clear();
    if (categories != null) instance.categories.addAll(categories);
    if (saleItems != null) instance.products.addAll(saleItems);
    if (deliveryOptions != null) instance.deliveryOptions.addAll(deliveryOptions);
    if (paymentOptions != null) instance.paymentOptions.addAll(paymentOptions);
  }
}
