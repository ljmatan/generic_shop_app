import 'package:flutter/material.dart';
import 'package:generic_shop_app_demo/demo.dart';

void main() {
  runApp(
    GsdPlugin(
      child: Gsa(
        navigatorKey: GlobalKey<NavigatorState>(),
      ),
    ),
  );
}
