import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_ivancica/endpoints/src/endpoints_products.dart';
import 'package:generic_shop_app_ivancica/models/src/response/model_product.dart';

///
///
class GivApiProducts extends GsarApi {
  const GivApiProducts._();

  /// Globally-accessible singleton class instance.
  ///
  static const instance = GivApiProducts._();

  @override
  String get host => 'api.ivancica.hr';

  @override
  String? get bearerToken => '7|tmUK2UIT7u6ocuxJTSNnkt7jtUZBjgzQeSelvOKX';

  /// Retrieves a list of sale items.
  ///
  Future<List<GsaaModelSaleItem>> getProducts() async {
    final response = await GivEndpointsProducts.getProductList.request(this);
    if (response is Iterable) {
      return [
        for (final jsonObject in response) GivModelProduct.fromJson(jsonObject).toSupportedType(),
      ];
    } else {
      throw 'Response is not of type Iterable: ${response.runtimeType}';
    }
  }
}
