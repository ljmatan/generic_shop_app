import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_architecture/gsa_architecture.dart';
import 'package:iot/api/src/api_firebase.dart';
import 'package:iot/models/src/model_firebase_realtime_iot.dart';

/// API interface implementation for communication with an ESP32 device
/// controlling the automated system.
///
class GiotApiEsp32Mcu extends GsarApi {
  const GiotApiEsp32Mcu._();

  /// Globally-accessible class instance.
  ///
  static const instance = GiotApiEsp32Mcu._();

  @override
  String get protocol => 'http';

  @override
  String get host => '192.168.43.183:80';

  @override
  String get url => '$protocol://$host/';

  /// Checks the connection by sending a request to serve the root web server content.
  ///
  Future<void> getConnectionStatus() async {
    await get(
      '',
      decodedResponse: false,
    );
  }

  /// Sends the current time information to the ESP32 device.
  ///
  Future<
      ({
        int temperature,
        int humidity,
      })?> setData({
    required ModelGiotFirebaseDatabaseIrrigationRules? irrigationRules,
  }) async {
    final response = await post(
      'data',
      {
        'timeIso8601': DateTime.now().toIso8601String(),
        if (irrigationRules != null) ...irrigationRules.toJson(),
      },
    );
    debugPrint('Set ESP32 data:\n${response.toString()}');
    try {
      final airStatus = (
        temperature: int.parse(response['temperature']),
        humidity: int.parse(response['humidity']),
      );
      GiotApiFirebase.instance
          .patchStatusInfo(
        airStatus.temperature,
        airStatus.humidity,
      )
          .catchError(
        (e) {
          debugPrint('$e');
        },
      );
      return airStatus;
    } catch (e) {
      return null;
    }
  }

  /// Requests for the atmosphere information to be forwarded from the ESP32 device.
  ///
  Future<
      ({
        num temperature,
        num humidity,
      })> getAtmosphereStatus() async {
    final response = await post(
      'data',
      {
        'timeIso8601': DateTime.now().toIso8601String(),
      },
    );
    final airStatus = (
      temperature: int.parse(response['temperature']),
      humidity: int.parse(response['humidity']),
    );
    GiotApiFirebase.instance
        .patchStatusInfo(
      airStatus.temperature,
      airStatus.humidity,
    )
        .catchError(
      (e) {
        debugPrint('$e');
      },
    );
    return airStatus;
  }
}
