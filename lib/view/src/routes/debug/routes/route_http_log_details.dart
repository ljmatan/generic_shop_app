part of '../route_debug.dart';

class _RouteHttpLogDetails extends GsarRoute {
  const _RouteHttpLogDetails();

  @override
  String get displayName => 'http-log-details';

  @override
  String get routeId => 'HTTP Log Details';

  @override
  GsarRouteState<_RouteHttpLogDetails> createState() => __RouteHttpLogDetailsState();
}

class __RouteHttpLogDetailsState extends GsarRouteState<_RouteHttpLogDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
