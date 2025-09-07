import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/arch.dart';

/// API endpoint call and handling implementation references.
///
extension GsaEndpointsSaleItemsImplExt on GsaEndpointsSaleItems {
  Function get implementation {
    switch (this) {
      case GsaEndpointsSaleItems.register:
        return GsaApiSaleItems.instance.register;
      case GsaEndpointsSaleItems.getItemDetails:
        return GsaApiSaleItems.instance.getItemDetails;
      case GsaEndpointsSaleItems.editItemDetails:
        return GsaApiSaleItems.instance.editItemDetails;
      case GsaEndpointsSaleItems.deleteAll:
        return GsaApiSaleItems.instance.deleteAll;
      case GsaEndpointsSaleItems.deleteSoft:
        return GsaApiSaleItems.instance.deleteSoft;
      case GsaEndpointsSaleItems.getAllItems:
        return GsaApiSaleItems.instance.getAllItems;
      case GsaEndpointsSaleItems.getItemCategories:
        return GsaApiSaleItems.instance.getItemCategories;
      case GsaEndpointsSaleItems.getFeaturedItems:
        return GsaApiSaleItems.instance.getFeaturedItems;
      case GsaEndpointsSaleItems.searchItems:
        return GsaApiSaleItems.instance.searchItems;
    }
  }
}

class GsaApiSaleItems extends GsaApi {
  const GsaApiSaleItems._();

  static const instance = GsaApiSaleItems._();

  @override
  String get protocol => 'http';

  /// Registers the given sale item data to the system.
  ///
  /// Returns the newly-created sale item ID on successful response.
  ///
  Future<String> register({required String name}) async {
    final response = await post(GsaEndpointsSaleItems.register.path, GsaModelSaleItem(name: name).toJson());
    final saleItemId = response['saleItemId'];
    if (saleItemId == null) {
      throw 'Sale item ID missing from the registration response.';
    } else {
      return saleItemId;
    }
  }

  /// Retrieves the details for the sale item with the specified [id] property.
  ///
  Future<String> getItemDetails({required String id}) async {
    final response = await get('${GsaEndpointsSaleItems.getItemDetails.path}?saleItemId=$id');
    final saleItemId = response['saleItemId'];
    if (saleItemId == null) {
      throw 'Sale item ID missing from the registration response.';
    } else {
      return saleItemId;
    }
  }

  /// Updates the sale item details with the provided values.
  ///
  Future<String> editItemDetails({required String saleItemId, String? name}) async {
    final response = await patch(GsaEndpointsSaleItems.editItemDetails.path, {'saleItemId': saleItemId, if (name != null) 'name': name});
    final responseSaleItemId = response['saleItemId'];
    if (responseSaleItemId == null) {
      throw 'Sale item ID missing from the registration response.';
    } else {
      return responseSaleItemId;
    }
  }

  /// Deletes the sale item with the specified [saleItemId] from the database.
  ///
  Future<void> deleteAll({required String saleItemId}) async {
    await delete(GsaEndpointsSaleItems.deleteAll.path, body: {'saleItemId': saleItemId});
  }

  /// Marks the sale item with the specified [saleItemId] as deleted without removing data from database.
  ///
  Future<void> deleteSoft({required String saleItemId}) async {
    await delete(GsaEndpointsSaleItems.deleteSoft.path, body: {'saleItemId': saleItemId});
  }

  /// Retrieves the complete list of available sale items.
  ///
  Future<List<GsaModelSaleItem>?> getAllItems() async {
    final response = await get(GsaEndpointsSaleItems.getAllItems.path);
    final saleItems = response['items'];
    if (saleItems is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return saleItems.map((saleItemJson) => GsaModelSaleItem.fromJson(saleItemJson)).toList();
    }
  }

  /// Retrieves the complete list of available sale items.
  ///
  Future<List<GsaModelCategory>?> getItemCategories() async {
    final response = await get(GsaEndpointsSaleItems.getItemCategories.path);
    final categories = response['categories'];
    if (categories is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return categories.map((categoryJson) => GsaModelCategory.fromJson(categoryJson)).toList();
    }
  }

  /// Retrieves the complete list of available sale items.
  ///
  Future<List<GsaModelSaleItem>?> getFeaturedItems() async {
    final response = await get(GsaEndpointsSaleItems.getFeaturedItems.path);
    final saleItems = response['items'];
    if (saleItems is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return saleItems.map((saleItemJson) => GsaModelSaleItem.fromJson(saleItemJson)).toList();
    }
  }

  /// Retrieves the complete list of available sale items.
  ///
  Future<List<GsaModelSaleItem>?> searchItems({required GsaModelShopSearch filters}) async {
    final response = await post(GsaEndpointsSaleItems.searchItems.path, filters.toJson());
    final saleItems = response['items'];
    if (saleItems is! Iterable) {
      // TODO: Log error
      return null;
    } else {
      return saleItems.map((saleItemJson) => GsaModelSaleItem.fromJson(saleItemJson)).toList();
    }
  }
}
