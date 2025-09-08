import 'package:flutter/material.dart';
import 'package:generic_shop_app_demo/demo.dart';

void main() {
  runApp(
    const GsdPlugin(
      child: Gsa(
        globalNavigatorKey: false,
      ),
    ),
  );
}
