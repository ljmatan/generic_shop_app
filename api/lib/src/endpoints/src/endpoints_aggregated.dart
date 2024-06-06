part of '../endpoints.dart';

enum GsaaEndpointsAggregated {
  getDataVersion,
  getMobileAppData,
}

extension GsaaEndpointsAggregatedPathExt on GsaaEndpointsAggregated {
  String get path {
    switch (this) {
      case GsaaEndpointsAggregated.getDataVersion:
        return 'check-version';
      case GsaaEndpointsAggregated.getMobileAppData:
        return 'mobile-app-data';
    }
  }

  String get method {
    return _method.id;
  }

  _EndpointMethodType get _method {
    switch (this) {
      case GsaaEndpointsAggregated.getDataVersion:
        return _EndpointMethodType.getRequest;
      case GsaaEndpointsAggregated.getMobileAppData:
        return _EndpointMethodType.getRequest;
    }
  }
}
