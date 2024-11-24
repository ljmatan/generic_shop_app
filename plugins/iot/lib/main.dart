import 'package:flutter/material.dart';
import 'package:iot/api/src/api_esp32_mcu.dart';
import 'package:iot/api/src/api_firebase.dart';
import 'package:iot/view/src/routes/dashboard/route_dashboard.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void giotBgCallbackDispatcher() {
  Workmanager().executeTask(
    (task, inputData) async {
      try {
        final irrigationInfo = await GiotApiFirebase.instance.getIrrigationInfo();
        await GiotApiEsp32Mcu.instance.setData(irrigationInfo.rules);
      } catch (e) {
        // ignore: avoid_print
        print('$e');
      }
      return Future.value(true);
    },
  );
}

void main() {
  Workmanager().registerPeriodicTask(
    'giotBackgroundTask',
    'giotBgCallbackDispatcher',
  );
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
