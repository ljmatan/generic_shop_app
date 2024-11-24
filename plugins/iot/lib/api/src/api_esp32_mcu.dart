import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// API interface implementation for communication with an ESP32 device
/// controlling the automated system.
///
class GiotApiEsp32Mcu extends GsaaApi {
  @override
  String get protocol => 'http';

  @override
  String get host => 'giotesp32.local';

  /// Sends the current time information to the ESP32 device.
  ///
  Future<void> setTime() async {
    await post(
      'time',
      {
        'timeIso8601': DateTime.now().toIso8601String(),
      },
    );
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

  /// Updates the ESP32 device with the latest irrigation settings.
  ///
  Future<void> updateIrrigationSettings({
    required int cycleRepeatTime,
    required int cycleTimeOffsetMinutes,
    required int cycleTimeSeconds,
    required int pauseTimeSeconds,
  }) async {
    await post(
      'irrigation',
      {
        'cycle_repeat_time': cycleRepeatTime,
        'cycle_time_offset_minutes': cycleTimeOffsetMinutes,
        'cycle_time_seconds': cycleTimeSeconds,
        'pause_time_seconds': pauseTimeSeconds,
      },
    );
  }
}
