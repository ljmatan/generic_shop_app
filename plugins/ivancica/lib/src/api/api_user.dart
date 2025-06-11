import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_ivancica/src/endpoints/endpoints_user.dart';
import 'package:generic_shop_app_ivancica/src/models/response/model_user.dart';

/// Methods related to the user APIs provided by the `api.ivancica.hr` service.
///
class GivApiUser extends GsaApi {
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
  Future<GsaModelUser> login({
    required String email,
    required String password,
  }) async {
    final response = await GivEndpointsUser.login.request(
      this,
      body: {
        'email': email,
        'password': password,
      },
    );
    return GivModelUser.fromJson(response).toSupportedType();
  }
}
