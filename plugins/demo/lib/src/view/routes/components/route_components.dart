import 'package:generic_shop_app_demo/src/view/routes/_routes.dart';
import 'package:flutter/material.dart';

class GsdRouteComponents extends GsdRoute {
  const GsdRouteComponents({super.key});

  @override
  State<GsdRouteComponents> createState() => _GsdRouteComponentsState();
}

class _GsdRouteComponentsState extends GsaRouteState<GsdRouteComponents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [],
      ),
    );
  }
}
