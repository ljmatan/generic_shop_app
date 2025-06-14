part of '../endpoints.dart';

/// Specified endpoints for the sale item API services.
///
enum GsaEndpointsSaleItems with GsaApiEndpoints {
  /// Registers a new sale item record into the database.
  ///
  register,

  /// Retrieves the details for a single specified item.
  ///
  getItemDetails,

  /// Updates the information for an existing item.
  ///
  editItemDetails,

  /// Deletes the specified and any associated database records.
  ///
  deleteAll,

  /// Marks the product as deleted, but does not remove the data from storage.
  ///
  deleteSoft,

  /// Retrieves a full list of merchant sale items.
  ///
  getAllItems,

  /// Returns the complete sale item categories information.
  ///
  getItemCategories,

  /// Retrieves a list of featured sale items.
  ///
  getFeaturedItems,

  /// Endpoint for generic sale item search (by text, with filters, etc.).
  ///
  searchItems;

  @override
  String get path {
    switch (this) {
      case GsaEndpointsSaleItems.register:
        return 'register';
      case GsaEndpointsSaleItems.getItemDetails:
        return 'details';
      case GsaEndpointsSaleItems.editItemDetails:
        return 'details';
      case GsaEndpointsSaleItems.deleteAll:
        return 'delete';
      case GsaEndpointsSaleItems.deleteSoft:
        return 'soft-delete';
      case GsaEndpointsSaleItems.getAllItems:
        return 'all-items';
      case GsaEndpointsSaleItems.getItemCategories:
        return 'categories';
      case GsaEndpointsSaleItems.getFeaturedItems:
        return 'featured-items';
      case GsaEndpointsSaleItems.searchItems:
        return 'search-items';
    }
  }

  @override
  GsaApiEndpointMethodType get method {
    switch (this) {
      case GsaEndpointsSaleItems.register:
        return GsaApiEndpointMethodType.httpPost;
      case GsaEndpointsSaleItems.getItemDetails:
        return GsaApiEndpointMethodType.httpGet;
      case GsaEndpointsSaleItems.editItemDetails:
        return GsaApiEndpointMethodType.httpPatch;
      case GsaEndpointsSaleItems.deleteAll:
        return GsaApiEndpointMethodType.httpDelete;
      case GsaEndpointsSaleItems.deleteSoft:
        return GsaApiEndpointMethodType.httpDelete;
      case GsaEndpointsSaleItems.getAllItems:
        return GsaApiEndpointMethodType.httpGet;
      case GsaEndpointsSaleItems.getItemCategories:
        return GsaApiEndpointMethodType.httpGet;
      case GsaEndpointsSaleItems.getFeaturedItems:
        return GsaApiEndpointMethodType.httpGet;
      case GsaEndpointsSaleItems.searchItems:
        return GsaApiEndpointMethodType.httpPost;
    }
  }
}
