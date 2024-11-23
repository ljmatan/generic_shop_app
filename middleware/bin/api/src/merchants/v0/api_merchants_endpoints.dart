part of '../../../api.dart';

extension GsaaEndpointsMerchantsExt on GsaaEndpointsMerchants {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaaEndpointsMerchants.register:
        return GsamApiMerchants0.instance.register;
      case GsaaEndpointsMerchants.getMerchantDetails:
        return GsamApiMerchants0.instance.getMerchantDetails;
      case GsaaEndpointsMerchants.editMerchantDetails:
        return GsamApiMerchants0.instance.editMerchantDetails;
      case GsaaEndpointsMerchants.deleteAll:
        return GsamApiMerchants0.instance.delete;
      case GsaaEndpointsMerchants.deleteSoft:
        return GsamApiMerchants0.instance.softDelete;
      case GsaaEndpointsMerchants.getAllMerchants:
        return GsamApiMerchants0.instance.getAllMerchants;
    }
  }
}
