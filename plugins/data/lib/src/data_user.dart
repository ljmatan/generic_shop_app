import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Data class implementing the merchant / vendor methods and properties.
///
class GsaDataUser extends GsaData {
  GsaDataUser._();

  // ignore: public_member_api_docs
  static final instance = GsaDataUser._();

  /// Application user data instance property.
  ///
  GsaModelUser? user;

  /// Whether the user is authenticated against the backend.
  ///
  bool get authenticated => user != null;

  @override
  Future<void> init({
    GsaModelUser? user,
  }) async {
    clear();
    instance.user = user;
  }

  @override
  void clear() {
    user = null;
  }
}
