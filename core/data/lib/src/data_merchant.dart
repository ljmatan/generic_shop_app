import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Data class implementing the merchant / vendor methods and properties.
///
class GsaDataMerchant extends GsaData {
  GsaDataMerchant._();

  /// Globally-accessible singleton class instance.
  ///
  static final instance = GsaDataMerchant._();

  /// Property holding the instance of the currently selected merchant.
  ///
  GsaModelMerchant? merchant;

  /// List of available merchants, if more than one are specified.
  ///
  List<GsaModelMerchant>? options;

  @override
  Future<void> init({
    GsaModelMerchant? merchant,
  }) async {
    await clear();
    instance.merchant = merchant;
  }

  @override
  Future<void> clear() async {
    merchant = null;
  }
}
