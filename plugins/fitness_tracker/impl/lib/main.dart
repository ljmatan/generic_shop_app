import 'package:flutter/material.dart';
import 'package:generic_shop_app_fitness_tracker/gft.dart';

void main() {
  GftPlugin.instance.configureClient();
  runApp(const Gsa());
}
