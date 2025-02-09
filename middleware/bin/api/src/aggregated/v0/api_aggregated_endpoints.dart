part of '../../../api.dart';

extension GsaEndpointsAggregatedExt on GsaEndpointsAggregated {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaEndpointsAggregated.getDataVersion:
        return GsamApiAggregated0.instance.getDataVersion;
      case GsaEndpointsAggregated.getMobileAppData:
        return GsamApiAggregated0.instance.getMobileAppData;
    }
  }
}
