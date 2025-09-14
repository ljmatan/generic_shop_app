import 'package:flutter/material.dart';
import 'package:generic_shop_app_cms/cms.dart';

class GscPageRoutes extends StatefulWidget {
  const GscPageRoutes({super.key});

  @override
  State<GscPageRoutes> createState() => _GscPageRoutesState();
}

class _GscPageRoutesState extends State<GscPageRoutes> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: GsaWidgetTodo(),
      ),
    );
  }
}
