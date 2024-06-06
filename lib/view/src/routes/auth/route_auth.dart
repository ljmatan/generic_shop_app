import 'package:flutter/material.dart';

enum _GsaRouteAuthType {
  passwordOnly,
  usernameAndPassword,
}

class GsaRouteAuth extends StatefulWidget {
  const GsaRouteAuth({super.key});

  @override
  State<GsaRouteAuth> createState() => _GsaRouteAuthState();

  @override
  String get routeId => 'auth';

  @override
  String get displayName => 'Authentication';
}

class _GsaRouteAuthState extends State<GsaRouteAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
