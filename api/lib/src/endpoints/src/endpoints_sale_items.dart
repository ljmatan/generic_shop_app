part of '../endpoints.dart';

/// Specified endpoints for the sale item API services.
///
enum GsaaEndpointsSaleItems implements GsarApiEndpoints {
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
      case GsaaEndpointsSaleItems.register:
        return 'register';
      case GsaaEndpointsSaleItems.getItemDetails:
        return 'details';
      case GsaaEndpointsSaleItems.editItemDetails:
        return 'details';
      case GsaaEndpointsSaleItems.deleteAll:
        return 'delete';
      case GsaaEndpointsSaleItems.deleteSoft:
        return 'soft-delete';
      case GsaaEndpointsSaleItems.getAllItems:
        return 'all-items';
      case GsaaEndpointsSaleItems.getItemCategories:
        return 'categories';
      case GsaaEndpointsSaleItems.getFeaturedItems:
        return 'featured-items';
      case GsaaEndpointsSaleItems.searchItems:
        return 'search-items';
    }
  }

  @override
  GsarApiEndpointMethodType get method {
    switch (this) {
      case GsaaEndpointsSaleItems.register:
        return GsarApiEndpointMethodType.httpPost;
      case GsaaEndpointsSaleItems.getItemDetails:
        return GsarApiEndpointMethodType.httpGet;
      case GsaaEndpointsSaleItems.editItemDetails:
        return GsarApiEndpointMethodType.httpPatch;
      case GsaaEndpointsSaleItems.deleteAll:
        return GsarApiEndpointMethodType.httpDelete;
      case GsaaEndpointsSaleItems.deleteSoft:
        return GsarApiEndpointMethodType.httpDelete;
      case GsaaEndpointsSaleItems.getAllItems:
        return GsarApiEndpointMethodType.httpGet;
      case GsaaEndpointsSaleItems.getItemCategories:
        return GsarApiEndpointMethodType.httpGet;
      case GsaaEndpointsSaleItems.getFeaturedItems:
        return GsarApiEndpointMethodType.httpGet;
      case GsaaEndpointsSaleItems.searchItems:
        return GsarApiEndpointMethodType.httpPost;
    }
  }

  @override
  GsarModel? get requestFields {
    return null;
  }

  @override
  GsarModel? get responseFields {
    return null;
  }
}
