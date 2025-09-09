import 'package:flutter/material.dart';
import 'package:generic_shop_app_fitness_tracker/fitness_tracker.dart';

void main() {
  final plugin = GftPlugin();
  runApp(
    GsaPluginWrapper(
      plugin: plugin,
      child: const Gsa(),
    ),
  );
}
