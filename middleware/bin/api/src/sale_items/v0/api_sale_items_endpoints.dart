part of '../../../api.dart';

extension GsaaEndpointsSaleItemsExt on GsaaEndpointsSaleItems {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaaEndpointsSaleItems.register:
        return GsamApiSaleItems0.instance.register;
      case GsaaEndpointsSaleItems.getItemDetails:
        return GsamApiSaleItems0.instance.getItemDetails;
      case GsaaEndpointsSaleItems.editItemDetails:
        return GsamApiSaleItems0.instance.editItemDetails;
      case GsaaEndpointsSaleItems.deleteAll:
        return GsamApiSaleItems0.instance.delete;
      case GsaaEndpointsSaleItems.deleteSoft:
        return GsamApiSaleItems0.instance.softDelete;
      case GsaaEndpointsSaleItems.getAllItems:
        return GsamApiSaleItems0.instance.getAllItems;
      case GsaaEndpointsSaleItems.getItemCategories:
        return GsamApiSaleItems0.instance.getItemCategories;
      case GsaaEndpointsSaleItems.getFeaturedItems:
        return GsamApiSaleItems0.instance.getFeaturedItems;
      case GsaaEndpointsSaleItems.searchItems:
        return GsamApiSaleItems0.instance.searchItems;
    }
  }
}
