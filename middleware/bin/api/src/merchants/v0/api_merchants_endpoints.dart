part of '../../../api.dart';

extension GsaEndpointsMerchantsExt on GsaEndpointsMerchants {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaEndpointsMerchants.register:
        return GsamApiMerchants0.instance.register;
      case GsaEndpointsMerchants.getMerchantDetails:
        return GsamApiMerchants0.instance.getMerchantDetails;
      case GsaEndpointsMerchants.editMerchantDetails:
        return GsamApiMerchants0.instance.editMerchantDetails;
      case GsaEndpointsMerchants.deleteAll:
        return GsamApiMerchants0.instance.delete;
      case GsaEndpointsMerchants.deleteSoft:
        return GsamApiMerchants0.instance.softDelete;
      case GsaEndpointsMerchants.getAllMerchants:
        return GsamApiMerchants0.instance.getAllMerchants;
    }
  }
}
