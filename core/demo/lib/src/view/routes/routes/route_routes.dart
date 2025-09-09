import 'package:flutter/material.dart';
import 'package:generic_shop_app_demo/demo.dart';

class GsdRouteRoutes extends GsdRoute {
  const GsdRouteRoutes({super.key});

  @override
  GsaRouteState<GsdRouteRoutes> createState() => _GsdRouteRoutesState();
}

class _GsdRouteRoutesState extends GsaRouteState<GsdRouteRoutes> {
  @override
  Widget view(BuildContext context) {
    return const Placeholder();
  }
}
