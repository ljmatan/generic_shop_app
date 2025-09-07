import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaRouteClients extends GsacRoute {
  const GsaRouteClients({super.key});

  @override
  GsaRouteState<GsaRouteClients> createState() => _GsaRouteClientsState();
}

class _GsaRouteClientsState extends GsaRouteState<GsaRouteClients> {
  @override
  Widget view(BuildContext context) {
    return const Placeholder();
  }
}
