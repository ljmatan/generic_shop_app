part of '../endpoints.dart';

enum GsaaEndpointsAggregated implements GsarApiEndpoints {
  getDataVersion,
  getMobileAppData;

  @override
  String get path {
    switch (this) {
      case GsaaEndpointsAggregated.getDataVersion:
        return 'check-version';
      case GsaaEndpointsAggregated.getMobileAppData:
        return 'mobile-app-data';
    }
  }

  @override
  GsarApiEndpointMethodType get method {
    switch (this) {
      case GsaaEndpointsAggregated.getDataVersion:
        return GsarApiEndpointMethodType.httpGet;
      case GsaaEndpointsAggregated.getMobileAppData:
        return GsarApiEndpointMethodType.httpGet;
    }
  }

  @override
  GsarModel? get requestFields {
    return null;
  }

  @override
  GsarModel? get responseFields {
    return null;
  }
}
