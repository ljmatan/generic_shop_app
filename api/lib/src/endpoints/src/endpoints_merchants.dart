part of '../endpoints.dart';

enum GsaaEndpointsMerchants {
  register,
  getMerchantDetails,
  editMerchantDetails,
  deleteAll,
  deleteSoft,
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
      case GsaaEndpointsMerchants.deleteAll:
        return 'delete';
      case GsaaEndpointsMerchants.deleteSoft:
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
      case GsaaEndpointsMerchants.deleteAll:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsMerchants.deleteSoft:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsMerchants.getAllMerchants:
        return _EndpointMethodType.getRequest;
    }
  }
}
