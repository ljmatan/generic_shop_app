import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/view.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Authentication options screen, used for displaying user authentication options.
///
class GsaRouteAuth extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteAuth({super.key});

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
