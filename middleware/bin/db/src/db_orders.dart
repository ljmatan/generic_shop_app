part of '../database.dart';

/// Predefined `orders` database collections.
///
enum _GsamDatabaseOrdersCollections {
  /// Currently-active order records.
  ///
  active,

  /// Completed orders.
  ///
  complete,

  /// Order-tracking logs aimed at statistical analysis.
  ///
  statistical,
}

class GsamDatabaseOrders extends GsamDatabase {
  GsamDatabaseOrders._() : super._();

  static final _instance = GsamDatabaseOrders._();

  factory GsamDatabaseOrders.instance(shelf.Request request) {
    return _instance(request) as GsamDatabaseOrders;
  }

  @override
  String get _name => 'orders';

  /// Records a new [user] entry to the database.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  Future<String> register({
    required GsaModelOrderDraft order,
    required String password,
  }) async {
    final orderId = await _instance._insertOne(
      collectionId: _GsamDatabaseOrdersCollections.active.name,
      body: order.toJson(),
    );
    return orderId;
  }

  /// Retrieves a first database record with a matching [userId] identifier value.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  Future<GsaModelOrderDraft?> findActiveById({
    required String userId,
  }) async {
    final result = await _instance._findOne(
      collectionId: _GsamDatabaseOrdersCollections.active.name,
      selectors: [('id', userId)],
    );
    if (result == null) return null;
    try {
      final serializedResult = GsaModelOrderDraft.fromJson(result);
      return serializedResult;
    } catch (e) {
      // TODO: Log etc.
      return null;
    }
  }

  /// Retrieves a first database record with a matching [userId] identifier value.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  Future<GsaModelOrderDraft?> findCompleteById({
    required String userId,
  }) async {
    final result = await _instance._findOne(
      collectionId: _GsamDatabaseOrdersCollections.complete.name,
      selectors: [('id', userId)],
    );
    if (result == null) return null;
    try {
      final serializedResult = GsaModelOrderDraft.fromJson(result);
      return serializedResult;
    } catch (e) {
      // TODO: Log etc.
      return null;
    }
  }

  /// Removes all of the user database records.
  ///
  Future<void> deleteActive({
    required String userId,
  }) async {
    await _instance._deleteOne(
      collectionId: _GsamDatabaseOrdersCollections.active.name,
      selectors: [('id', userId)],
    );
  }

  /// Removes all of the user database records.
  ///
  Future<void> deleteComplete({
    required String userId,
  }) async {
    await _instance._deleteOne(
      collectionId: _GsamDatabaseOrdersCollections.complete.name,
      selectors: [('id', userId)],
    );
  }

  /// Removes any personal user-associated data from the database by rewriting them.
  ///
  Future<void> softDeleteActive({
    required String userId,
  }) async {
    await _instance._updateOne(
      collectionId: _GsamDatabaseOrdersCollections.active.name,
      selectors: [('id', userId)],
      body: {
        'username': 'DELETED',
        'personalDetails': null,
        'contact': null,
        'address': null,
      },
    );
  }

  /// Removes any personal user-associated data from the database by rewriting them.
  ///
  Future<void> softDeleteComplete({
    required String userId,
  }) async {
    await _instance._updateOne(
      collectionId: _GsamDatabaseOrdersCollections.complete.name,
      selectors: [('id', userId)],
      body: {
        'username': 'DELETED',
        'personalDetails': null,
        'contact': null,
        'address': null,
      },
    );
  }
}
