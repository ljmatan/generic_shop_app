import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:iot/models/src/model_firebase_realtime_iot.dart';

/// API interface implementation for communication with an ESP32 device
/// controlling the automated system.
///
class GiotApiEsp32Mcu extends GsaaApi {
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
      return (
        temperature: int.parse(response['temperature']),
        humidity: int.parse(response['humidity']),
      );
    } catch (e) {
      return null;
    }
  }

  /// Requests for the atmosphere information to be forwarded from the ESP32 device.
  ///
  Future<
      ({
        num? temperature,
        num? humidity,
      })?> getAtmosphereStatus() async {
    final response = await get('status/atmosphere');
    try {
      final json = Map<String, dynamic>.from(response);
      return (
        temperature: num.tryParse(json['temperature'].toString()),
        humidity: num.tryParse(json['humidity'].toString()),
      );
    } catch (e) {
      return null;
    }
  }
}
