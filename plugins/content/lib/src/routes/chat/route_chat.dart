import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Screen providing chat functionalities.
///
class GsaRouteChat extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteChat({super.key});

  @override
  State<GsaRouteChat> createState() => _GsaRouteChatState();
}

class _GsaRouteChatState extends GsaRouteState<GsaRouteChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
        ],
      ),
    );
  }
}
