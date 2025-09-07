import 'package:flutter/material.dart';
import 'package:generic_shop_app_demo/demo.dart';

void main() {
  GsdPlugin.instance.configureClient();
  runApp(Gsa());
}
