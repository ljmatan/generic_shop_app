part of '../endpoints.dart';

/// Specified endpoints for the sale item API services.
///
enum GsaaEndpointsSaleItems {
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
  delete,

  /// Marks the product as deleted, but does not remove the data from storage.
  ///
  softDelete,

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
  searchItems,
}

extension GsaaEndpointsSaleItemsPathExt on GsaaEndpointsSaleItems {
  String get path {
    switch (this) {
      case GsaaEndpointsSaleItems.register:
        return 'register';
      case GsaaEndpointsSaleItems.getItemDetails:
        return 'details';
      case GsaaEndpointsSaleItems.editItemDetails:
        return 'details';
      case GsaaEndpointsSaleItems.delete:
        return 'delete';
      case GsaaEndpointsSaleItems.softDelete:
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

  String get method {
    return _method.id;
  }

  _EndpointMethodType get _method {
    switch (this) {
      case GsaaEndpointsSaleItems.register:
        return _EndpointMethodType.postRequest;
      case GsaaEndpointsSaleItems.getItemDetails:
        return _EndpointMethodType.getRequest;
      case GsaaEndpointsSaleItems.editItemDetails:
        return _EndpointMethodType.patchRequest;
      case GsaaEndpointsSaleItems.delete:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsSaleItems.softDelete:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsSaleItems.getAllItems:
        return _EndpointMethodType.getRequest;
      case GsaaEndpointsSaleItems.getItemCategories:
        return _EndpointMethodType.getRequest;
      case GsaaEndpointsSaleItems.getFeaturedItems:
        return _EndpointMethodType.getRequest;
      case GsaaEndpointsSaleItems.searchItems:
        return _EndpointMethodType.postRequest;
    }
  }
}
