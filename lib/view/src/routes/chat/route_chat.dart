import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Screen providing chat functionalities.
///
class GsaRouteChat extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteChat({super.key});

  @override
  State<GsaRouteChat> createState() => _GsaRouteChatState();
}

class _GsaRouteChatState extends GsarRouteState<GsaRouteChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.displayName,
        ),
      ),
    );
  }
}
