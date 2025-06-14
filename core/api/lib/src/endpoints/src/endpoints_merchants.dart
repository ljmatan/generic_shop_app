part of '../endpoints.dart';

enum GsaEndpointsMerchants with GsaApiEndpoints {
  register,
  getMerchantDetails,
  editMerchantDetails,
  deleteAll,
  deleteSoft,
  getAllMerchants;

  @override
  String get path {
    switch (this) {
      case GsaEndpointsMerchants.register:
        return 'register';
      case GsaEndpointsMerchants.getMerchantDetails:
        return 'details';
      case GsaEndpointsMerchants.editMerchantDetails:
        return 'details';
      case GsaEndpointsMerchants.deleteAll:
        return 'delete';
      case GsaEndpointsMerchants.deleteSoft:
        return 'soft-delete';
      case GsaEndpointsMerchants.getAllMerchants:
        return 'all-merchants';
    }
  }

  @override
  GsaApiEndpointMethodType get method {
    switch (this) {
      case GsaEndpointsMerchants.register:
        return GsaApiEndpointMethodType.httpPost;
      case GsaEndpointsMerchants.getMerchantDetails:
        return GsaApiEndpointMethodType.httpGet;
      case GsaEndpointsMerchants.editMerchantDetails:
        return GsaApiEndpointMethodType.httpPatch;
      case GsaEndpointsMerchants.deleteAll:
        return GsaApiEndpointMethodType.httpDelete;
      case GsaEndpointsMerchants.deleteSoft:
        return GsaApiEndpointMethodType.httpDelete;
      case GsaEndpointsMerchants.getAllMerchants:
        return GsaApiEndpointMethodType.httpGet;
    }
  }
}
