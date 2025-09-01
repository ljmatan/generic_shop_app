import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// API endpoint call and handling implementation references.
///
extension GsaEndpointsMerchantsImplExt on GsaEndpointsMerchants {
  Function get implementation {
    switch (this) {
      case GsaEndpointsMerchants.register:
        return GsaApiMerchants.instance.register;
      case GsaEndpointsMerchants.getMerchantDetails:
        return GsaApiMerchants.instance.getMerchantDetails;
      case GsaEndpointsMerchants.editMerchantDetails:
        return GsaApiMerchants.instance.editMerchantDetails;
      case GsaEndpointsMerchants.deleteAll:
        return GsaApiMerchants.instance.deleteAll;
      case GsaEndpointsMerchants.deleteSoft:
        return GsaApiMerchants.instance.deleteSoft;
      case GsaEndpointsMerchants.getAllMerchants:
        return GsaApiMerchants.instance.getAllMerchants;
    }
  }
}

/// Merchant / vendor related API calls and logic.
///
class GsaApiMerchants extends GsaApi {
  const GsaApiMerchants._();

  /// Globally-accessible singleton class instance.
  ///
  static const instance = GsaApiMerchants._();

  @override
  String get protocol => 'http';

  /// Registers a merchant instance into the system database.
  ///
  Future<String> register({required String name}) async {
    final response = await post(GsaEndpointsMerchants.register.path, GsaModelMerchant(name: name).toJson());
    final merchantId = response['merchantId'];
    if (merchantId == null) {
      throw 'Merchant ID missing from registration response.';
    } else {
      return merchantId;
    }
  }

  /// Registers a merchant instance into the system database.
  ///
  Future<GsaModelMerchant> getMerchantDetails({required String merchantId}) async {
    final response = await get('${GsaEndpointsMerchants.getMerchantDetails.path}?merchantId=$merchantId');
    return GsaModelMerchant.fromJson(response);
  }

  /// Registers a merchant instance into the system database.
  ///
  Future<void> editMerchantDetails({required String name}) async {
    await patch(GsaEndpointsMerchants.editMerchantDetails.path, {'name': name});
  }

  /// Removes a merchant instance from the system database.
  ///
  Future<void> deleteAll({required String merchantId}) async {
    await delete(GsaEndpointsMerchants.deleteAll.path, body: {'merchantId': merchantId});
  }

  /// Sets the merchant status as deleted in the database, but does not actually remove the data.
  ///
  Future<void> deleteSoft({required String merchantId}) async {
    await delete(GsaEndpointsMerchants.deleteSoft.path, body: {'merchantId': merchantId});
  }

  /// Retrieves the list of all the merchants available to the user.
  ///
  Future<List<GsaModelMerchant>?> getAllMerchants() async {
    final response = await get(GsaEndpointsMerchants.getAllMerchants.path);
    final merchants = response['merchants'];
    if (merchants is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return merchants.map((merchantJson) => GsaModelMerchant.fromJson(merchantJson)).toList();
    }
  }
}
