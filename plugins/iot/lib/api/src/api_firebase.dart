import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:iot/models/src/model_firebase_realtime_iot.dart';

/// Firebase REST API services based on the
/// [Realtime Database](https://firebase.google.com/docs/database).
///
class GiotApiFirebase extends GsaaApi {
  GiotApiFirebase._();

  /// Globally-accessible class instance.
  ///
  static final instance = GiotApiFirebase._();

  @override
  String get host => 'mushroom-farm-tim-default-rtdb.europe-west1.firebasedatabase.app';

  @override
  String get url => '$protocol://$host/';

  /// Suffix applied to request URLs in order to comply with the
  /// [Firebase Authentication rules](https://firebase.google.com/docs/database/rest/auth).
  ///
  final _urlSuffix = '.json';

  /// Retrieves the contents of the entire database.
  ///
  Future<Map<String, dynamic>> getAllDatabaseContents() async {
    final response = await get(_urlSuffix);
    return Map<String, dynamic>.from(response);
  }

  /// Retrieves the status information from the server.
  ///
  Future<ModelGiotFirebaseDatabaseStatus> getStatusInfo() async {
    final response = await get('status$_urlSuffix');
    return ModelGiotFirebaseDatabaseStatus.fromJson(response);
  }

  /// Updates the status information on the server.
  ///
  Future<void> patchStatusInfo(
    num temperature,
    num humidity,
  ) async {
    debugPrint((
      await patch(
        'status$_urlSuffix',
        {
          'time': DateTime.now().toIso8601String(),
          'temperature': temperature,
          'humidity': humidity,
        },
      ),
    ).toString());
  }

  /// Retrieves the heating information from the server.
  ///
  Future<ModelGiotFirebaseDatabaseHeating> getHeatingInfo() async {
    final response = await get('heating$_urlSuffix');
    return ModelGiotFirebaseDatabaseHeating.fromJson(response);
  }

  /// Retrieves the irrigation information from the server.
  ///
  Future<ModelGiotFirebaseDatabaseIrrigation> getIrrigationInfo() async {
    final response = await get('irrigation$_urlSuffix');
    return ModelGiotFirebaseDatabaseIrrigation.fromJson(response);
  }

  /// Retrieves the lighting information from the server.
  ///
  Future<ModelGiotFirebaseDatabaseLights> getLightsInfo() async {
    final response = await get('lights$_urlSuffix');
    return ModelGiotFirebaseDatabaseLights.fromJson(response);
  }

  /// Retrieves the ventilation information from the server.
  ///
  Future<ModelGiotFirebaseDatabaseVentilation> getVentilationInfo() async {
    final response = await get('ventilation$_urlSuffix');
    return ModelGiotFirebaseDatabaseVentilation.fromJson(response);
  }

  /// Uploades a camera image to the server.
  ///
  Future<void> postCameraImage(String imageBase64) async {
    await post(
      'media$_urlSuffix',
      {
        'time': DateTime.now().toIso8601String(),
        'imageBase64': imageBase64,
      },
    );
  }

  /// Uploads a camera image to the server.
  ///
  Future<void> postLogEntry(Map<String, dynamic> body) async {
    await post(
      'logs$_urlSuffix',
      {
        'time': DateTime.now().toIso8601String(),
        for (final entry in body.entries) entry.key: entry.value,
      },
    );
  }
}
