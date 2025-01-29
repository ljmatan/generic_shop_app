part of '../endpoints.dart';

enum GsaaEndpointsMerchants with GsarApiEndpoints {
  register,
  getMerchantDetails,
  editMerchantDetails,
  deleteAll,
  deleteSoft,
  getAllMerchants;

  @override
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

  @override
  GsarApiEndpointMethodType get method {
    switch (this) {
      case GsaaEndpointsMerchants.register:
        return GsarApiEndpointMethodType.httpPost;
      case GsaaEndpointsMerchants.getMerchantDetails:
        return GsarApiEndpointMethodType.httpGet;
      case GsaaEndpointsMerchants.editMerchantDetails:
        return GsarApiEndpointMethodType.httpPatch;
      case GsaaEndpointsMerchants.deleteAll:
        return GsarApiEndpointMethodType.httpDelete;
      case GsaaEndpointsMerchants.deleteSoft:
        return GsarApiEndpointMethodType.httpDelete;
      case GsaaEndpointsMerchants.getAllMerchants:
        return GsarApiEndpointMethodType.httpGet;
    }
  }
}
