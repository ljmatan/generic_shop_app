import 'package:flutter/material.dart';
import 'package:generic_shop_app_demo/gsd.dart';

void main() {
  GsdPlugin.instance.configureClient();
  runApp(Gsa());
}
