import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_ivancica/src/endpoints/endpoints_products.dart';
import 'package:generic_shop_app_ivancica/src/models/response/model_sale_item.dart';

/// Methods related to the product APIs provided by the `api.ivancica.hr` service.
///
class GivApiProducts extends GsaApi {
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
  Future<List<GsaModelSaleItem>> getProducts() async {
    final response = await GivEndpointsProducts.getProductList.request(
      this,
      body: {
        'products_ids': const <String>{
          '24432',
          '24518',
          '24555',
          '21188',
          '21189',
          '21197',
          '21198',
          '21199',
          '21200',
          '24968',
          '21201',
          '24969',
          '21202',
          '21203',
          '21204',
          '21205',
          '21206',
          '21207',
          '24568',
          '24569',
          '24575',
          '21301',
          '21313',
          '21320',
          '21321',
          '21338',
          '21352',
        }.join(','),
      },
    );
    if (response is Iterable) {
      return [
        for (final jsonObject in response) GivModelSaleItem.fromJson(jsonObject).toSupportedType(),
      ];
    } else {
      throw 'Response is not of type Iterable: ${response.runtimeType}';
    }
  }
}
