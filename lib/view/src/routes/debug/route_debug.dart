import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';

/// Route integrated with development / debugging features.
///
class GsaRouteDebug extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteDebug({super.key});

  @override
  State<GsaRouteDebug> createState() => _GsaRouteDebugState();

  @override
  String get routeId => 'debug';

  @override
  String get displayName => 'Debug';
}

class _GsaRouteDebugState extends GsaRouteState<GsaRouteDebug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
