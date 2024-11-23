part of '../../../api.dart';

extension GsaaEndpointsAggregatedExt on GsaaEndpointsAggregated {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaaEndpointsAggregated.getDataVersion:
        return GsamApiAggregated0.instance.getDataVersion;
      case GsaaEndpointsAggregated.getMobileAppData:
        return GsamApiAggregated0.instance.getMobileAppData;
    }
  }
}
