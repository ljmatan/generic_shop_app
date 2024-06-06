/// Central point for the common Generic Shop App services.

library generic_shop_app_api;

import 'package:generic_shop_app_api/generic_shop_app_api.dart';

export 'src/api/api.dart';
export 'src/endpoints/endpoints.dart';
export 'src/models/models.dart';
export 'src/services/services.dart';

class GsaaConfig {
  GsaaConfig._();

  static Future<void> init() async {
    await GsaaService.initAll();
  }
}
