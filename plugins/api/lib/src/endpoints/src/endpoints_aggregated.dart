part of '../endpoints.dart';

enum GsaEndpointsAggregated with GsaApiEndpoints {
  getDataVersion,
  getMobileAppData;

  @override
  String get path {
    switch (this) {
      case GsaEndpointsAggregated.getDataVersion:
        return 'check-version';
      case GsaEndpointsAggregated.getMobileAppData:
        return 'mobile-app-data';
    }
  }

  @override
  GsaApiEndpointMethodType get method {
    switch (this) {
      case GsaEndpointsAggregated.getDataVersion:
        return GsaApiEndpointMethodType.httpGet;
      case GsaEndpointsAggregated.getMobileAppData:
        return GsaApiEndpointMethodType.httpGet;
    }
  }
}
