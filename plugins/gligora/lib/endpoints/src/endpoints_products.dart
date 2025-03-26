import 'package:generic_shop_app_architecture/gsar.dart';

/// API endpoints implemented for product operations.
///
enum GliEndpointsProducts with GsaApiEndpoints {
  /// Retrieves a list of products according to the specified parameters.
  ///
  getProductList;

  @override
  String get path {
    switch (this) {
      case GliEndpointsProducts.getProductList:
        return 'api/products/main-page?lang=hr';
    }
  }

  @override
  GsaApiEndpointMethodType get method {
    switch (this) {
      case GliEndpointsProducts.getProductList:
        return GsaApiEndpointMethodType.httpGet;
    }
  }
}
