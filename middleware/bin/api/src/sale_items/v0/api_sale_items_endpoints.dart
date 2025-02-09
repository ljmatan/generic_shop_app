part of '../../../api.dart';

extension GsaEndpointsSaleItemsExt on GsaEndpointsSaleItems {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaEndpointsSaleItems.register:
        return GsamApiSaleItems0.instance.register;
      case GsaEndpointsSaleItems.getItemDetails:
        return GsamApiSaleItems0.instance.getItemDetails;
      case GsaEndpointsSaleItems.editItemDetails:
        return GsamApiSaleItems0.instance.editItemDetails;
      case GsaEndpointsSaleItems.deleteAll:
        return GsamApiSaleItems0.instance.delete;
      case GsaEndpointsSaleItems.deleteSoft:
        return GsamApiSaleItems0.instance.softDelete;
      case GsaEndpointsSaleItems.getAllItems:
        return GsamApiSaleItems0.instance.getAllItems;
      case GsaEndpointsSaleItems.getItemCategories:
        return GsamApiSaleItems0.instance.getItemCategories;
      case GsaEndpointsSaleItems.getFeaturedItems:
        return GsamApiSaleItems0.instance.getFeaturedItems;
      case GsaEndpointsSaleItems.searchItems:
        return GsamApiSaleItems0.instance.searchItems;
    }
  }
}
