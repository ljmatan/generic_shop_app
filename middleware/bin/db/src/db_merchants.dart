part of '../database.dart';

/// Predefined `merchants` database collections.
///
enum _GsamDatabaseMerchantsCollections {
  merchants,

  /// Merchant category definitions.
  ///
  categories,
}

class GsamDatabaseMerchants extends GsamDatabase {
  GsamDatabaseMerchants._() : super._();

  static final _instance = GsamDatabaseMerchants._();

  factory GsamDatabaseMerchants.instance(shelf.Request request) {
    return _instance(request) as GsamDatabaseMerchants;
  }

  @override
  String get _name => 'merchants';

  /// Records a new [merchant] entry to the database.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  /// Returns the newly-created merchant ID.
  ///
  Future<String> register({
    required GsaModelMerchant merchant,
    required String password,
  }) async {
    final merchantId = await _instance._insertOne(
      collectionId: _GsamDatabaseMerchantsCollections.merchants.name,
      body: merchant.toJson(),
    );
    return merchantId;
  }

  /// Retrieves a first database record with a matching [merchantId] identifier value.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  Future<GsaModelMerchant?> findById({
    required String merchantId,
  }) async {
    final result = await _instance._findOne(
      collectionId: _GsamDatabaseMerchantsCollections.merchants.name,
      selectors: [('id', merchantId)],
    );
    if (result == null) return null;
    try {
      final serializedResult = GsaModelMerchant.fromJson(result);
      return serializedResult;
    } catch (e) {
      // TODO: Log etc.
      return null;
    }
  }

  /// Retrieves a first database record with a matching [username] identifier value.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  Future<GsaModelMerchant?> findByName({
    required String username,
  }) async {
    final result = await _instance._findOne(
      collectionId: _GsamDatabaseMerchantsCollections.merchants.name,
      selectors: [('name', username)],
    );
    if (result == null) return null;
    try {
      final serializedResult = GsaModelMerchant.fromJson(result);
      return serializedResult;
    } catch (e) {
      // TODO: Log etc.
      return null;
    }
  }

  /// Removes all of the user database records.
  ///
  Future<void> delete({
    required String userId,
  }) async {
    await _instance._deleteOne(
      collectionId: _GsamDatabaseMerchantsCollections.merchants.name,
      selectors: [('id', userId)],
    );
  }

  /// Removes any personal user-associated data from the database by rewriting them.
  ///
  Future<void> softDelete({
    required String userId,
  }) async {
    await _instance._updateOne(
      collectionId: _GsamDatabaseMerchantsCollections.merchants.name,
      selectors: [('id', userId)],
      body: {
        'username': 'DELETED',
        'personalDetails': null,
        'contact': null,
        'address': null,
      },
    );
  }

  /// Updates the stored user data with the specified values.
  ///
  Future<void> updateMerchantDetails({
    required String userId,
    required Map<String, dynamic> body,
  }) async {
    await _instance._updateOne(
      collectionId: _GsamDatabaseMerchantsCollections.merchants.name,
      selectors: [('id', userId)],
      body: body,
    );
  }

  Future<List<GsaModelMerchant>?> getAllMerchants({
    List<(String, String)>? selectors,
  }) async {
    final results = await _instance._findMany(
      collectionId: _GsamDatabaseMerchantsCollections.merchants.name,
      selectors: selectors,
    );
    if (results == null) return null;
    try {
      return results.map((merchantJson) => GsaModelMerchant.fromJson(merchantJson)).toList();
    } catch (e) {
      // TODO: Log etc.
      return null;
    }
  }
}
