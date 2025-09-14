import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';

class GscPageComponents extends StatefulWidget {
  const GscPageComponents({super.key});

  @override
  State<GscPageComponents> createState() => _GscPageComponentsState();
}

class _GscPageComponentsState extends State<GscPageComponents> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: GsaWidgetTodo(),
      ),
    );
  }
}
