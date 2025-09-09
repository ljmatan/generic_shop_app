import 'package:flutter/material.dart';
import 'package:generic_shop_app_demo/demo.dart';

void main() {
  final plugin = GsdPlugin();
  runApp(
    GsaPluginWrapper(
      plugin: plugin,
      child: Gsa(
        navigatorKey: GlobalKey<NavigatorState>(),
      ),
    ),
  );
}
