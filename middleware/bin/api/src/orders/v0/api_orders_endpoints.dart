part of '../../../api.dart';

extension GsaEndpointsOrdersExt on GsaEndpointsOrders {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaEndpointsOrders.register:
        return GsamApiOrders0.instance.register;
      case GsaEndpointsOrders.deleteAll:
        return GsamApiOrders0.instance.delete;
      case GsaEndpointsOrders.deleteSoft:
        return GsamApiOrders0.instance.softDelete;
      case GsaEndpointsOrders.createOrUpdateDraft:
        return GsamApiOrders0.instance.createOrUpdateDraft;
      case GsaEndpointsOrders.confirmDraft:
        return GsamApiOrders0.instance.confirmDraft;
    }
  }
}
