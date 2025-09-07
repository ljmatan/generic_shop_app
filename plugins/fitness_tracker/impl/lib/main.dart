import 'package:flutter/material.dart';
import 'package:generic_shop_app_fitness_tracker/fitness_tracker.dart';

void main() {
  GftPlugin.instance.configureClient();
  runApp(const Gsa());
}
