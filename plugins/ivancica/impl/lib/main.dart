import 'package:flutter/material.dart';
import 'package:generic_shop_app_ivancica/giv.dart';

void main() {
  GivPlugin.instance.configureClient();
  runApp(const Gsa());
}
