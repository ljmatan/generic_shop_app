part of '../endpoints.dart';

enum GsaaEndpointsOrders {
  /// Registers a new order into the database.
  ///
  register,

  /// Removes the order record from the database.
  ///
  delete,

  /// Marks the order as deleted, and removes any privately-associated data from the database.
  ///
  softDelete,

  /// Endpoint used for creating or updating the order draft, with order overview as the return value.
  ///
  createOrUpdateDraft,

  /// Marks the order draft as confirmed from the user side.
  ///
  confirmDraft,
}

extension GsaaEndpointsOrdersPathExt on GsaaEndpointsOrders {
  String get path {
    switch (this) {
      case GsaaEndpointsOrders.register:
        return 'register';
      case GsaaEndpointsOrders.delete:
        return 'delete';
      case GsaaEndpointsOrders.softDelete:
        return 'soft-delete';
      case GsaaEndpointsOrders.createOrUpdateDraft:
        return 'create-draft';
      case GsaaEndpointsOrders.confirmDraft:
        return 'confirm-draft';
    }
  }

  String get method {
    return _method.id;
  }

  _EndpointMethodType get _method {
    switch (this) {
      case GsaaEndpointsOrders.register:
        return _EndpointMethodType.postRequest;
      case GsaaEndpointsOrders.delete:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsOrders.softDelete:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsOrders.createOrUpdateDraft:
        return _EndpointMethodType.putRequest;
      case GsaaEndpointsOrders.confirmDraft:
        return _EndpointMethodType.postRequest;
    }
  }
}
