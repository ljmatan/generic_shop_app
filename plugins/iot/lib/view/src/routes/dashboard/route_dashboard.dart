import 'package:flutter/material.dart';
import 'package:iot/api/src/api_esp32_mcu.dart';
import 'package:iot/api/src/api_firebase.dart';

class GiotRouteDashboard extends StatefulWidget {
  const GiotRouteDashboard({super.key});

  @override
  State<GiotRouteDashboard> createState() => _GiotRouteDashboardState();
}

class _GiotRouteDashboardState extends State<GiotRouteDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GiotApiFirebase.instance.getIrrigationInfo().then(
          (value) async {
            await GiotApiEsp32Mcu.instance.getConnectionStatus();
            await GiotApiEsp32Mcu.instance.setData(
              irrigationRules: value.rules,
            );
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return Center(
            child: Icon(Icons.check),
          );
        },
      ),
    );
  }
}
