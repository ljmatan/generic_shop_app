import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// API endpoint call and handling implementation references.
///
extension GsaaEndpointsMerchantsImplExt on GsaaEndpointsMerchants {
  Function get implementation {
    switch (this) {
      case GsaaEndpointsMerchants.register:
        return GsaaApiMerchants.instance.register;
      case GsaaEndpointsMerchants.getMerchantDetails:
        return GsaaApiMerchants.instance.getMerchantDetails;
      case GsaaEndpointsMerchants.editMerchantDetails:
        return GsaaApiMerchants.instance.editMerchantDetails;
      case GsaaEndpointsMerchants.deleteAll:
        return GsaaApiMerchants.instance.deleteAll;
      case GsaaEndpointsMerchants.deleteSoft:
        return GsaaApiMerchants.instance.deleteSoft;
      case GsaaEndpointsMerchants.getAllMerchants:
        return GsaaApiMerchants.instance.getAllMerchants;
    }
  }
}

/// Merchant / vendor related API calls and logic.
///
class GsaaApiMerchants extends GsarApi {
  const GsaaApiMerchants._();

  /// Globally-accessible singleton class instance.
  ///
  static const instance = GsaaApiMerchants._();

  @override
  String get protocol => 'http';

  @override
  String get identifier => 'merchants';

  @override
  int get version => 0;

  /// Registers a merchant instance into the system database.
  ///
  Future<String> register({required String name}) async {
    final response = await post(GsaaEndpointsMerchants.register.path, GsaaModelMerchant(name: name).toJson());
    final merchantId = response['merchantId'];
    if (merchantId == null) {
      throw 'Merchant ID missing from registration response.';
    } else {
      return merchantId;
    }
  }

  /// Registers a merchant instance into the system database.
  ///
  Future<GsaaModelMerchant> getMerchantDetails({required String merchantId}) async {
    final response = await get('${GsaaEndpointsMerchants.getMerchantDetails.path}?merchantId=$merchantId');
    return GsaaModelMerchant.fromJson(response);
  }

  /// Registers a merchant instance into the system database.
  ///
  Future<void> editMerchantDetails({required String name}) async {
    await patch(GsaaEndpointsMerchants.editMerchantDetails.path, {'name': name});
  }

  /// Removes a merchant instance from the system database.
  ///
  Future<void> deleteAll({required String merchantId}) async {
    await delete(GsaaEndpointsMerchants.deleteAll.path, body: {'merchantId': merchantId});
  }

  /// Sets the merchant status as deleted in the database, but does not actually remove the data.
  ///
  Future<void> deleteSoft({required String merchantId}) async {
    await delete(GsaaEndpointsMerchants.deleteSoft.path, body: {'merchantId': merchantId});
  }

  /// Retrieves the list of all the merchants available to the user.
  ///
  Future<List<GsaaModelMerchant>?> getAllMerchants() async {
    final response = await get(GsaaEndpointsMerchants.getAllMerchants.path);
    final merchants = response['merchants'];
    if (merchants is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return merchants.map((merchantJson) => GsaaModelMerchant.fromJson(merchantJson)).toList();
    }
  }
}
