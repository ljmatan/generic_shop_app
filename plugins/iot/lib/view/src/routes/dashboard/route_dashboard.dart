import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:iot/api/src/api_esp32_mcu.dart';
import 'package:iot/api/src/api_firebase.dart';

class GiotRouteDashboard extends StatefulWidget {
  const GiotRouteDashboard({super.key});

  @override
  State<GiotRouteDashboard> createState() => _GiotRouteDashboardState();
}

class _GiotRouteDashboardState extends State<GiotRouteDashboard> {
  /// Atmosphere information retrieved from the microcontroller unit.
  ///
  int? _temperatureCelsius, _humidityPercentage;

  /// Defines whether the atmosphere information is currently being refreshed.
  ///
  bool _refreshingAtmosphereInfo = false;

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
            _temperatureCelsius = airStatus?.temperature;
            _humidityPercentage = airStatus?.humidity;
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: GsaWidgetLoadingIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: GsaWidgetText(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
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
                      value: _temperatureCelsius,
                    ),
                    (
                      label: 'Humidity',
                      measure: '%',
                      value: _humidityPercentage,
                    ),
                  }.indexed)
                    Expanded(
                      child: Padding(
                        padding: airStat.$1 == 0 ? const EdgeInsets.only(right: 4) : const EdgeInsets.only(left: 4),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Theme.of(context).primaryColor,
                            child: Center(
                              child: Padding(
                                padding: Theme.of(context).cardPadding,
                                child: Column(
                                  children: [
                                    GsaWidgetText(
                                      '${airStat.$2.value}${airStat.$2.measure}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    GsaWidgetText(
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
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 80,
                child: Center(
                  child: StatefulBuilder(
                    builder: (context, setButtonState) {
                      return _refreshingAtmosphereInfo
                          ? SizedBox.square(
                              dimension: 16,
                              child: GsaWidgetLoadingIndicator(),
                            )
                          : GsaWidgetButton.outlined(
                              label: 'REFRESH',
                              icon: Icons.refresh,
                              foregroundColor: Colors.white,
                              onTap: () async {
                                setButtonState(() => _refreshingAtmosphereInfo = true);
                                try {
                                  final airStatus = await GiotApiEsp32Mcu.instance.getAtmosphereStatus();
                                  _temperatureCelsius = airStatus.temperature.toInt();
                                  _humidityPercentage = airStatus.humidity.toInt();
                                } catch (e) {
                                  debugPrint('Error retrieving airStatus: $e');
                                }
                                setState(() => _refreshingAtmosphereInfo = false);
                              },
                            );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
