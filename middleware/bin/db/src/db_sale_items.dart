part of '../database.dart';

/// Predefined `saleItems` database collections.
///
enum _GsamDatabaseSaleItemsCollections {
  /// Collection of sale item categories.
  ///
  categories,

  /// List of recorded merchant products.
  ///
  products,

  /// Collection of sale item options.
  ///
  options,

  /// Recorded coupon entries.
  ///
  coupons,
}

class GsamDatabaseSaleItems extends GsamDatabase {
  GsamDatabaseSaleItems._() : super._();

  static final _instance = GsamDatabaseSaleItems._();

  factory GsamDatabaseSaleItems.instance(shelf.Request request) {
    return _instance(request) as GsamDatabaseSaleItems;
  }

  @override
  String get _name => 'saleItems';

  /// Records a new [saleItem] entry to the database.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  Future<String> register({
    required GsaModelSaleItem saleItem,
  }) async {
    final saleItemId = await _instance._insertOne(
      collectionId: _GsamDatabaseSaleItemsCollections.products.name,
      body: saleItem.toJson(),
    );
    return saleItemId;
  }

  /// Retrieves a full list of sale items with the given [collectionId].
  ///
  Future<List<GsaModelSaleItem>?> getAllItems() async {
    final saleItems = await _instance._findMany(
      collectionId: _GsamDatabaseSaleItemsCollections.products.name,
    );
    try {
      return saleItems?.map((saleItemJson) => GsaModelSaleItem.fromJson(saleItemJson)).toList();
    } catch (e) {
      // TODO: Log error
      return null;
    }
  }

  /// Retrieves a full list of item categories.
  ///
  Future<List<GsaModelCategory>?> getItemCategories() async {
    final categories = await _instance._findMany(
      collectionId: _GsamDatabaseSaleItemsCollections.categories.name,
    );
    try {
      return categories?.map((saleItemJson) => GsaModelCategory.fromJson(saleItemJson)).toList();
    } catch (e) {
      // TODO: Log error
      return null;
    }
  }

  /// Retrieves a list of sale items specified as featured.
  ///
  Future<List<GsaModelSaleItem>?> getFeaturedItems() async {
    final saleItems = await _instance._findMany(
      collectionId: _GsamDatabaseSaleItemsCollections.products.name,
      selectors: [
        ('featured', true),
      ],
    );
    try {
      return saleItems?.map((saleItemJson) => GsaModelSaleItem.fromJson(saleItemJson)).toList();
    } catch (e) {
      // TODO: Log error
      return null;
    }
  }

  /// Retrieves a list of sale items matching the specified search criteria.
  ///
  Future<List<GsaModelSaleItem>?> searchItems() async {
    final saleItems = await _instance._findMany(
      collectionId: _GsamDatabaseSaleItemsCollections.products.name,
    );
    try {
      return saleItems?.map((saleItemJson) => GsaModelSaleItem.fromJson(saleItemJson)).toList();
    } catch (e) {
      // TODO: Log error
      return null;
    }
  }
}
