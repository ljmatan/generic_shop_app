part of '../route_debug.dart';

class _WidgetLogDetailsRoute extends StatelessWidget {
  const _WidgetLogDetailsRoute(
    this.route,
  );

  final GsaRouteState<GsaRoute> route;

  @override
  Widget build(BuildContext context) {
    return GsaWidgetText(
      route.widget.displayName,
    );
  }
}
