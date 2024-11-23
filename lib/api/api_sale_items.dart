import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// API endpoint call and handling implementation references.
///
extension GsaaEndpointsSaleItemsImplExt on GsaaEndpointsSaleItems {
  Function get implementation {
    switch (this) {
      case GsaaEndpointsSaleItems.register:
        return GsaaApiSaleItems.instance.register;
      case GsaaEndpointsSaleItems.getItemDetails:
        return GsaaApiSaleItems.instance.getItemDetails;
      case GsaaEndpointsSaleItems.editItemDetails:
        return GsaaApiSaleItems.instance.editItemDetails;
      case GsaaEndpointsSaleItems.deleteAll:
        return GsaaApiSaleItems.instance.deleteAll;
      case GsaaEndpointsSaleItems.deleteSoft:
        return GsaaApiSaleItems.instance.deleteSoft;
      case GsaaEndpointsSaleItems.getAllItems:
        return GsaaApiSaleItems.instance.getAllItems;
      case GsaaEndpointsSaleItems.getItemCategories:
        return GsaaApiSaleItems.instance.getItemCategories;
      case GsaaEndpointsSaleItems.getFeaturedItems:
        return GsaaApiSaleItems.instance.getFeaturedItems;
      case GsaaEndpointsSaleItems.searchItems:
        return GsaaApiSaleItems.instance.searchItems;
    }
  }
}

class GsaaApiSaleItems extends GsaaApi {
  const GsaaApiSaleItems._();

  static const instance = GsaaApiSaleItems._();

  @override
  String get _protocol => 'http';

  @override
  String get _identifier => 'sale-items';

  @override
  int get _version => 0;

  /// Registers the given sale item data to the system.
  ///
  /// Returns the newly-created sale item ID on successful response.
  ///
  Future<String> register({
    required String name,
  }) async {
    final response = await post(
      GsaaEndpointsSaleItems.register.path,
      GsaaModelSaleItem(
        name: name,
      ).toJson(),
    );
    final saleItemId = response['saleItemId'];
    if (saleItemId == null) {
      throw 'Sale item ID missing from the registration response.';
    } else {
      return saleItemId;
    }
  }

  /// Retrieves the details for the sale item with the specified [id] property.
  ///
  Future<String> getItemDetails({
    required String id,
  }) async {
    final response = await get(
      '${GsaaEndpointsSaleItems.getItemDetails.path}?saleItemId=$id',
    );
    final saleItemId = response['saleItemId'];
    if (saleItemId == null) {
      throw 'Sale item ID missing from the registration response.';
    } else {
      return saleItemId;
    }
  }

  /// Updates the sale item details with the provided values.
  ///
  Future<String> editItemDetails({
    required String saleItemId,
    String? name,
  }) async {
    final response = await patch(
      GsaaEndpointsSaleItems.editItemDetails.path,
      {
        'saleItemId': saleItemId,
        if (name != null) 'name': name,
      },
    );
    final responseSaleItemId = response['saleItemId'];
    if (responseSaleItemId == null) {
      throw 'Sale item ID missing from the registration response.';
    } else {
      return responseSaleItemId;
    }
  }

  /// Deletes the sale item with the specified [saleItemId] from the database.
  ///
  Future<void> deleteAll({
    required String saleItemId,
  }) async {
    await delete(
      GsaaEndpointsSaleItems.deleteAll.path,
      body: {
        'saleItemId': saleItemId,
      },
    );
  }

  /// Marks the sale item with the specified [saleItemId] as deleted without removing data from database.
  ///
  Future<void> deleteSoft({
    required String saleItemId,
  }) async {
    await delete(
      GsaaEndpointsSaleItems.deleteSoft.path,
      body: {
        'saleItemId': saleItemId,
      },
    );
  }

  /// Retrieves the complete list of available sale items.
  ///
  Future<List<GsaaModelSaleItem>?> getAllItems() async {
    final response = await get(
      GsaaEndpointsSaleItems.getAllItems.path,
    );
    final saleItems = response['items'];
    if (saleItems is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return saleItems.map((saleItemJson) => GsaaModelSaleItem.fromJson(saleItemJson)).toList();
    }
  }

  /// Retrieves the complete list of available sale items.
  ///
  Future<List<GsaaModelCategory>?> getItemCategories() async {
    final response = await get(
      GsaaEndpointsSaleItems.getItemCategories.path,
    );
    final categories = response['categories'];
    if (categories is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return categories.map((categoryJson) => GsaaModelCategory.fromJson(categoryJson)).toList();
    }
  }

  /// Retrieves the complete list of available sale items.
  ///
  Future<List<GsaaModelSaleItem>?> getFeaturedItems() async {
    final response = await get(
      GsaaEndpointsSaleItems.getFeaturedItems.path,
    );
    final saleItems = response['items'];
    if (saleItems is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return saleItems.map((saleItemJson) => GsaaModelSaleItem.fromJson(saleItemJson)).toList();
    }
  }

  /// Retrieves the complete list of available sale items.
  ///
  Future<List<GsaaModelSaleItem>?> searchItems({
    required GsaaModelShopSearch filters,
  }) async {
    final response = await post(
      GsaaEndpointsSaleItems.searchItems.path,
      filters.toJson(),
    );
    final saleItems = response['items'];
    if (saleItems is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return saleItems.map((saleItemJson) => GsaaModelSaleItem.fromJson(saleItemJson)).toList();
    }
  }
}
