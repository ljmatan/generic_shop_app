part of '../endpoints.dart';

enum GsaaEndpointsMerchants {
  register,
  getMerchantDetails,
  editMerchantDetails,
  delete,
  softDelete,
  getAllMerchants,
}

extension GsaaEndpointsMerchantsPathExt on GsaaEndpointsMerchants {
  String get path {
    switch (this) {
      case GsaaEndpointsMerchants.register:
        return 'register';
      case GsaaEndpointsMerchants.getMerchantDetails:
        return 'details';
      case GsaaEndpointsMerchants.editMerchantDetails:
        return 'details';
      case GsaaEndpointsMerchants.delete:
        return 'delete';
      case GsaaEndpointsMerchants.softDelete:
        return 'soft-delete';
      case GsaaEndpointsMerchants.getAllMerchants:
        return 'all-merchants';
    }
  }

  String get method {
    return _method.id;
  }

  _EndpointMethodType get _method {
    switch (this) {
      case GsaaEndpointsMerchants.register:
        return _EndpointMethodType.postRequest;
      case GsaaEndpointsMerchants.getMerchantDetails:
        return _EndpointMethodType.getRequest;
      case GsaaEndpointsMerchants.editMerchantDetails:
        return _EndpointMethodType.patchRequest;
      case GsaaEndpointsMerchants.delete:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsMerchants.softDelete:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsMerchants.getAllMerchants:
        return _EndpointMethodType.getRequest;
    }
  }
}
