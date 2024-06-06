part of '../api.dart';

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
      case GsaaEndpointsMerchants.delete:
        return GsaaApiMerchants.instance.delete;
      case GsaaEndpointsMerchants.softDelete:
        return GsaaApiMerchants.instance.softDelete;
      case GsaaEndpointsMerchants.getAllMerchants:
        return GsaaApiMerchants.instance.getAllMerchants;
    }
  }
}

/// Merchant / vendor related API calls and logic.
///
class GsaaApiMerchants extends GsaaApi {
  const GsaaApiMerchants._() : super._();

  static const instance = GsaaApiMerchants._();

  @override
  String get _protocol => 'http';

  @override
  String get _identifier => 'merchants';

  @override
  int get _version => 0;

  /// Registers a merchant instance into the system database.
  ///
  Future<String> register({
    required String name,
  }) async {
    final response = await _post(
      GsaaEndpointsMerchants.register.path,
      GsaaModelMerchant(
        name: name,
      ).toJson(),
    );
    final merchantId = response['merchantId'];
    if (merchantId == null) {
      throw 'Merchant ID missing from registration response.';
    } else {
      return merchantId;
    }
  }

  /// Registers a merchant instance into the system database.
  ///
  Future<GsaaModelMerchant> getMerchantDetails({
    required String merchantId,
  }) async {
    final response = await _get(
      '${GsaaEndpointsMerchants.getMerchantDetails.path}?merchantId=$merchantId',
    );
    return GsaaModelMerchant.fromJson(response);
  }

  /// Registers a merchant instance into the system database.
  ///
  Future<void> editMerchantDetails({
    required String name,
  }) async {
    await _patch(
      GsaaEndpointsMerchants.editMerchantDetails.path,
      {
        'name': name,
      },
    );
  }

  /// Removes a merchant instance from the system database.
  ///
  Future<void> delete({
    required String merchantId,
  }) async {
    await _delete(
      GsaaEndpointsMerchants.delete.path,
      body: {
        'merchantId': merchantId,
      },
    );
  }

  /// Sets the merchant status as deleted in the database, but does not actually remove the data.
  ///
  Future<void> softDelete({
    required String merchantId,
  }) async {
    await _delete(
      GsaaEndpointsMerchants.softDelete.path,
      body: {
        'merchantId': merchantId,
      },
    );
  }

  /// Retrieves the list of all the merchants available to the user.
  ///
  Future<List<GsaaModelMerchant>?> getAllMerchants() async {
    final response = await _get(
      GsaaEndpointsMerchants.getAllMerchants.path,
    );
    final merchants = response['merchants'];
    if (merchants is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return merchants.map((merchantJson) => GsaaModelMerchant.fromJson(merchantJson)).toList();
    }
  }
}
