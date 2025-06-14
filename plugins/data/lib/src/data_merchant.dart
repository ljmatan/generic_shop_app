import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Data class implementing the merchant / vendor methods and properties.
///
class GsaDataMerchant extends GsaData {
  GsaDataMerchant._();

  // ignore: public_member_api_docs
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
    clear();
    instance.merchant = merchant;
  }

  @override
  void clear() {
    merchant = null;
  }
}
