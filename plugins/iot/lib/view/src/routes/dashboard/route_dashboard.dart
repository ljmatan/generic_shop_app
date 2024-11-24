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
            final airStatus = await GiotApiEsp32Mcu.instance.setData(
              irrigationRules: value.rules,
            );
            return (
              temperature: airStatus?.temperature,
              humidity: airStatus?.humidity,
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
          return ListView(
            children: [
              Row(
                children: [
                  for (final airStat in <({
                    String label,
                    String measure,
                    dynamic value,
                  })>{
                    (
                      label: 'Temperature',
                      measure: '°C',
                      value: snapshot.data?.temperature,
                    ),
                    (
                      label: 'Humidity',
                      measure: '%',
                      value: snapshot.data?.humidity,
                    ),
                  }.indexed)
                    Padding(
                      padding: airStat.$1 == 0 ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                      child: Card(
                        color: Colors.blue.shade200,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                '${airStat.$2.value}${airStat.$2.measure}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                airStat.$2.label,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
