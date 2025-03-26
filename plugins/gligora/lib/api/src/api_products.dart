import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_gligora/endpoints/endpoints.dart';
import 'package:generic_shop_app_gligora/models/models.dart';

/// Methods related to the product APIs provided by the `api.ivancica.hr` service.
///
class GliApiProducts extends GsaApi {
  const GliApiProducts._();

  /// Globally-accessible singleton class instance.
  ///
  static const instance = GliApiProducts._();

  @override
  String get host => 'cms.webshop.gligora.com';

  /// Retrieves a list of sale items.
  ///
  Future<List<GsaModelSaleItem>> getProducts() async {
    final response = await GliEndpointsProducts.getProductList.request(this);
    if (response['data'] is Iterable) {
      return [
        for (final jsonObject in response['data']) GliModelProduct.fromJson(jsonObject).toSupportedType(),
      ];
    } else {
      throw 'Response is not of type Iterable: ${response['data'].runtimeType}';
    }
  }
}
