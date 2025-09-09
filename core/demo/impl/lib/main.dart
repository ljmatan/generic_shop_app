import 'package:flutter/material.dart';
import 'package:generic_shop_app_demo/demo.dart';

void main() {
  runApp(
    GsaPluginWrapper(
      plugin: GsdPlugin.pluginCollection.first,
      child: Gsa(
        navigatorKey: GlobalKey<NavigatorState>(),
      ),
    ),
  );
}
