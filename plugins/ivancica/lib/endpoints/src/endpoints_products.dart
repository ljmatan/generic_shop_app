import 'package:generic_shop_app_architecture/gsar.dart';

/// API endpoints implemented for product operations.
///
enum GivEndpointsProducts with GsarApiEndpoints {
  /// Retrieves a list of products according to the specified parameters.
  ///
  getProductList;

  @override
  String get path {
    switch (this) {
      case GivEndpointsProducts.getProductList:
        return 'shop/products/get_products';
    }
  }

  @override
  GsarApiEndpointMethodType get method {
    switch (this) {
      case GivEndpointsProducts.getProductList:
        return GsarApiEndpointMethodType.httpPost;
    }
  }
}
