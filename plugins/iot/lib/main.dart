import 'package:flutter/material.dart';
import 'package:iot/view/src/routes/dashboard/route_dashboard.dart';

void main() {
  runApp(
    const _GsapIotApp(),
  );
}

class _GsapIotApp extends StatefulWidget {
  const _GsapIotApp();

  @override
  State<_GsapIotApp> createState() => _GsapIotAppState();
}

class _GsapIotAppState extends State<_GsapIotApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GiotRouteDashboard(),
    );
  }
}
