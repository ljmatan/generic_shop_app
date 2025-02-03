import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_ivancica/endpoints/src/endpoints_user.dart';
import 'package:generic_shop_app_ivancica/models/src/response/model_product.dart';

/// Methods related to the user APIs provided by the `api.ivancica.hr` service.
///
class GivApiUser extends GsarApi {
  const GivApiUser._();

  /// Globally-accessible singleton class instance.
  ///
  static const instance = GivApiUser._();

  @override
  String get host => 'api.ivancica.hr';

  @override
  String? get bearerToken => '7|tmUK2UIT7u6ocuxJTSNnkt7jtUZBjgzQeSelvOKX';

  /// Retrieves a list of sale items.
  ///
  Future<dynamic> login() async {
    final response = await GivEndpointsUser.login.request(this);
  }
}
