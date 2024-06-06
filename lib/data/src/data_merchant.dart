import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app_api/src/models/models.dart';

/// Data class implementing the merchant / vendor methods and properties.
///
class GsaDataMerchant extends GsaData {
  GsaDataMerchant._();

  // ignore: public_member_api_docs
  static final instance = GsaDataMerchant._();

  /// Property holding the instance of the currently selected merchant.
  ///
  GsaaModelMerchant? merchant;

  /// List of available merchants, if more than one are specified.
  ///
  List<GsaaModelMerchant>? options;

  @override
  Future<void> init({
    GsaaModelMerchant? merchant,
  }) async {
    clear();
    instance.merchant = merchant;
  }

  @override
  void clear() {
    merchant = null;
  }
}
