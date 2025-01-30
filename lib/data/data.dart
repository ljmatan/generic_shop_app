/// Library defining the global application data access points.

library data;

import 'package:generic_shop_app/data/src/data_checkout.dart';
import 'package:generic_shop_app/data/src/data_merchant.dart';
import 'package:generic_shop_app/data/src/data_sale_items.dart';
import 'package:generic_shop_app/data/src/data_user.dart';

export 'src/data_checkout.dart';
export 'src/data_merchant.dart';
export 'src/data_sale_items.dart';
export 'src/data_user.dart';

/// Below declaration is required to ensure object memory allocation.
///
// ignore: unused_element
final _instances = [
  GsaDataCheckout.instance,
  GsaDataMerchant.instance,
  GsaDataSaleItems.instance,
  GsaDataUser.instance,
];
