part of '../endpoints.dart';

enum GsaEndpointsOrders with GsaApiEndpoints {
  /// Registers a new order into the database.
  ///
  register,

  /// Removes the order record from the database.
  ///
  deleteAll,

  /// Marks the order as deleted, and removes any privately-associated data from the database.
  ///
  deleteSoft,

  /// Endpoint used for creating or updating the order draft, with order overview as the return value.
  ///
  createOrUpdateDraft,

  /// Marks the order draft as confirmed from the user side.
  ///
  confirmDraft;

  @override
  String get path {
    switch (this) {
      case GsaEndpointsOrders.register:
        return 'register';
      case GsaEndpointsOrders.deleteAll:
        return 'delete';
      case GsaEndpointsOrders.deleteSoft:
        return 'soft-delete';
      case GsaEndpointsOrders.createOrUpdateDraft:
        return 'create-draft';
      case GsaEndpointsOrders.confirmDraft:
        return 'confirm-draft';
    }
  }

  @override
  GsaApiEndpointMethodType get method {
    switch (this) {
      case GsaEndpointsOrders.register:
        return GsaApiEndpointMethodType.httpPost;
      case GsaEndpointsOrders.deleteAll:
        return GsaApiEndpointMethodType.httpDelete;
      case GsaEndpointsOrders.deleteSoft:
        return GsaApiEndpointMethodType.httpDelete;
      case GsaEndpointsOrders.createOrUpdateDraft:
        return GsaApiEndpointMethodType.httpPut;
      case GsaEndpointsOrders.confirmDraft:
        return GsaApiEndpointMethodType.httpPost;
    }
  }
}
