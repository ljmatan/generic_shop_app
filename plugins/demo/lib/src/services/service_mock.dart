import 'dart:math';

import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_data/data.dart';

/// Service implemented for incorporating mock or fake data into the application.
///
class GsdServiceMock extends GsaService {
  GsdServiceMock._();

  /// Globally-accessible class instance.
  ///
  static final instance = GsdServiceMock._();

  @override
  Future<void> init() async {
    await super.init();

    // Allocate app user information.
    GsaDataUser.instance.user = GsaModelUser.mock();

    // Allocate app merchant / vendor information.
    GsaDataMerchant.instance.merchant = GsaModelMerchant.mock();

    // Allocate sale item information.
    GsaDataSaleItems.instance.categories = [
      for (int i = 0; i < 10; i++) GsaModelCategory.mock(),
    ];
    GsaDataSaleItems.instance.collection = [
      for (int i = 0; i < 100; i++)
        GsaModelSaleItem.mock(
          categoryId: GsaDataSaleItems.instance.categories[Random().nextInt(10)].id,
        ),
    ];
    GsaDataSaleItems.instance.deliveryOptions = [
      for (int i = 0; i < 3; i++) GsaModelSaleItem.mock(),
    ];
    GsaDataSaleItems.instance.paymentOptions = [
      for (int i = 0; i < 3; i++) GsaModelSaleItem.mock(),
    ];
  }
}
