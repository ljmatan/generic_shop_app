import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

enum _GsaRouteAuthType {
  passwordOnly,
  usernameAndPassword,
}

class GsaRouteAuth extends GsarRoute {
  const GsaRouteAuth({super.key});

  @override
  String get routeId => 'auth';

  @override
  String get displayName => 'Authentication';

  @override
  GsarRouteState<GsaRouteAuth> createState() => _GsaRouteAuthState();
}

class _GsaRouteAuthState extends GsarRouteState<GsaRouteAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
