import 'package:generic_shop_app_demo/src/view/routes/_routes.dart';
import 'package:flutter/material.dart';

class GsdRouteWidgets extends GsdRoute {
  const GsdRouteWidgets({super.key});

  @override
  State<GsdRouteWidgets> createState() => _GsdRouteComponentsState();
}

class _GsdRouteComponentsState extends GsaRouteState<GsdRouteWidgets> {
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [],
      ),
    );
  }
}
