import 'package:flutter/material.dart';
import 'package:generic_shop_app_cms/cms.dart';

void main() {
  final plugin = GscPlugin();
  runApp(
    GsaPluginWrapper(
      plugin: plugin,
      child: Gsa(
        navigatorKey: GlobalKey<NavigatorState>(),
      ),
    ),
  );
}
