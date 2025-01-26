part of '../endpoints.dart';

enum GsaaEndpointsOrders implements GsarApiEndpoints {
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
      case GsaaEndpointsOrders.register:
        return 'register';
      case GsaaEndpointsOrders.deleteAll:
        return 'delete';
      case GsaaEndpointsOrders.deleteSoft:
        return 'soft-delete';
      case GsaaEndpointsOrders.createOrUpdateDraft:
        return 'create-draft';
      case GsaaEndpointsOrders.confirmDraft:
        return 'confirm-draft';
    }
  }

  @override
  GsarApiEndpointMethodType get method {
    switch (this) {
      case GsaaEndpointsOrders.register:
        return GsarApiEndpointMethodType.httpPost;
      case GsaaEndpointsOrders.deleteAll:
        return GsarApiEndpointMethodType.httpDelete;
      case GsaaEndpointsOrders.deleteSoft:
        return GsarApiEndpointMethodType.httpDelete;
      case GsaaEndpointsOrders.createOrUpdateDraft:
        return GsarApiEndpointMethodType.httpPut;
      case GsaaEndpointsOrders.confirmDraft:
        return GsarApiEndpointMethodType.httpPost;
    }
  }
}
