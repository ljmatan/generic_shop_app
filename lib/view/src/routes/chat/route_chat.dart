import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';

class GsaRouteChat extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteChat({super.key});

  @override
  State<GsaRouteChat> createState() => _GsaRouteChatState();

  @override
  String get routeId => 'chat';

  @override
  String get displayName => 'Chat';
}

class _GsaRouteChatState extends GsaRouteState<GsaRouteChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
