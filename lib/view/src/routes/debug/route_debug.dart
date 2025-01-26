import 'package:flutter/material.dart';
import 'package:gsa_architecture/gsar.dart';

/// Route integrated with development / debugging features.
///
class GsaRouteDebug extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteDebug({super.key});

  @override
  State<GsaRouteDebug> createState() => _GsaRouteDebugState();

  @override
  String get routeId => 'debug';

  @override
  String get displayName => 'Debug';
}

class _GsaRouteDebugState extends GsarRouteState<GsaRouteDebug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
