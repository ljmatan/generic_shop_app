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
    required GsaaModelSaleItem saleItem,
  }) async {
    final saleItemId = await _instance._insertOne(
      collectionId: _GsamDatabaseSaleItemsCollections.products.name,
      body: saleItem.toJson(),
    );
    return saleItemId;
  }

  /// Retrieves a full list of sale items with the given [collectionId].
  ///
  Future<List<GsaaModelSaleItem>?> getAllItems() async {
    final saleItems = await _instance._findMany(
      collectionId: _GsamDatabaseSaleItemsCollections.products.name,
    );
    try {
      return saleItems?.map((saleItemJson) => GsaaModelSaleItem.fromJson(saleItemJson)).toList();
    } catch (e) {
      // TODO: Log error
      return null;
    }
  }

  /// Retrieves a full list of item categories.
  ///
  Future<List<GsaaModelCategory>?> getItemCategories() async {
    final categories = await _instance._findMany(
      collectionId: _GsamDatabaseSaleItemsCollections.categories.name,
    );
    try {
      return categories?.map((saleItemJson) => GsaaModelCategory.fromJson(saleItemJson)).toList();
    } catch (e) {
      // TODO: Log error
      return null;
    }
  }

  /// Retrieves a list of sale items specified as featured.
  ///
  Future<List<GsaaModelSaleItem>?> getFeaturedItems() async {
    final saleItems = await _instance._findMany(
      collectionId: _GsamDatabaseSaleItemsCollections.products.name,
      selectors: [
        ('featured', true),
      ],
    );
    try {
      return saleItems?.map((saleItemJson) => GsaaModelSaleItem.fromJson(saleItemJson)).toList();
    } catch (e) {
      // TODO: Log error
      return null;
    }
  }

  /// Retrieves a list of sale items matching the specified search criteria.
  ///
  Future<List<GsaaModelSaleItem>?> searchItems() async {
    final saleItems = await _instance._findMany(
      collectionId: _GsamDatabaseSaleItemsCollections.products.name,
    );
    try {
      return saleItems?.map((saleItemJson) => GsaaModelSaleItem.fromJson(saleItemJson)).toList();
    } catch (e) {
      // TODO: Log error
      return null;
    }
  }
}
