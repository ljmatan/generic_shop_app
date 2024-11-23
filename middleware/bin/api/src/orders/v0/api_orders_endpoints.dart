part of '../../../api.dart';

extension GsaaEndpointsOrdersExt on GsaaEndpointsOrders {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaaEndpointsOrders.register:
        return GsamApiOrders0.instance.register;
      case GsaaEndpointsOrders.deleteAll:
        return GsamApiOrders0.instance.delete;
      case GsaaEndpointsOrders.deleteSoft:
        return GsamApiOrders0.instance.softDelete;
      case GsaaEndpointsOrders.createOrUpdateDraft:
        return GsamApiOrders0.instance.createOrUpdateDraft;
      case GsaaEndpointsOrders.confirmDraft:
        return GsamApiOrders0.instance.confirmDraft;
    }
  }
}
