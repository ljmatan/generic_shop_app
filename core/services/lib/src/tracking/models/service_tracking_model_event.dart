part of '../service_tracking.dart';

/// Event entry specified for the [GsaServiceTracking] feature.
///
/// The event specifies all of the parameters required for user activity collection.
///
class GsaServiceTrackingModelEvent {
  void _assignLogValues() {
    userId ??= null; // TODO.
    timeIso8601 ??= DateTime.now().toIso8601String();
    platform ??= GsaServiceTrackingModelEventPlatform.current;
    platformVersionId ??= null; // TODO.
    appId ??= null; // TODO.
    appVersionId ??= null; // TODO.
    gsaLibVersionId ??= GsaConfig.version;
  }

  /// Constructs a new instance of a statistics event log entry.
  ///
  GsaServiceTrackingModelEvent.statistics({
    required this.id,
    this.properties,
  })  : statistics = true,
        marketing = false {
    _assignLogValues();
  }

  /// Constructs a new instance of a marketing event log entry.
  ///
  GsaServiceTrackingModelEvent.marketing({
    required this.id,
    this.properties,
  })  : statistics = false,
        marketing = true {
    _assignLogValues();
  }

  /// Constructs a new class instance from JSON data.
  ///
  GsaServiceTrackingModelEvent._fromJson({
    required this.statistics,
    required this.marketing,
    required this.id,
    required this.userId,
    required this.timeIso8601,
    required this.properties,
    this.platform,
    this.platformVersionId,
    this.appId,
    this.appVersionId,
    this.gsaLibVersionId,
  });

  /// Whether this event logs are used for statistics or marketing purposes.
  ///
  bool statistics, marketing;

  /// Event identifier value.
  ///
  String? id;

  /// Identifier associated with a specific app user.
  ///
  String? userId;

  /// Time of the log entry in ISO8601 format.
  ///
  String? timeIso8601;

  /// Time of the log entry in [DateTime] format.
  ///
  DateTime? get time {
    if (timeIso8601 == null) {
      return null;
    }
    return DateTime.tryParse(timeIso8601!);
  }

  /// Event properties (e.g., product ID, price, payment method, error code...).
  ///
  Map<String, String>? properties;

  /// Device platform the log is collected from.
  ///
  GsaServiceTrackingModelEventPlatform? platform;

  /// The platform operating system version identifier.
  ///
  String? platformVersionId;

  /// The identifier for the application client integration.
  ///
  String? appId;

  /// The identifier for this version of the Generic Shop App integration.
  ///
  String? appVersionId;

  /// Identifier for the version of the Generic Shop App library.
  ///
  String? gsaLibVersionId;

  /// Generates a class instance from JSON-compatible format.
  ///
  factory GsaServiceTrackingModelEvent.fromJson(Map json) {
    return GsaServiceTrackingModelEvent._fromJson(
      statistics: json['statistics'] == 1,
      marketing: json['marketing'] == 1,
      id: json['id'],
      userId: json['userId'],
      timeIso8601: json['timeIso8601'],
      properties: json['properties'] == null
          ? null
          : Map.from(
              jsonDecode(
                json['properties'],
              ),
            ),
      platform: GsaServiceTrackingModelEventPlatform.values.firstWhereOrNull(
        (platform) {
          return platform.name == json['platform'];
        },
      ),
      platformVersionId: json['platformVersionId'],
      appId: json['appId'],
      appVersionId: json['appVersionId'],
      gsaLibVersionId: json['gsaLibVersionId'],
    );
  }

  /// Method for serialising the class value with JSON-compatible format.
  ///
  Map<String, dynamic> toJson() {
    return {
      'statistics': statistics ? 1 : 0,
      'marketing': marketing ? 1 : 0,
      'id': id,
      'userId': userId,
      'timeIso8601': timeIso8601,
      'properties': properties == null
          ? null
          : jsonEncode(
              properties,
            ),
      'platform': platform?.name,
      'platformVersionId': platformVersionId,
      'appId': appId,
      'appVersionId': appVersionId,
      'gsaLibVersionId': gsaLibVersionId,
    };
  }
}

/// Identifiers for the platforms the app is supporting for event logging.
///
enum GsaServiceTrackingModelEventPlatform {
  /// Android.
  ///
  android,

  /// iOS.
  ///
  iOS,

  /// Web.
  ///
  web,

  /// MacOS.
  ///
  macOS,

  /// Linux.
  ///
  linux,

  /// Windows.
  ///
  windows;

  static GsaServiceTrackingModelEventPlatform get current {
    if (kIsWeb || kIsWasm) {
      return GsaServiceTrackingModelEventPlatform.web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return GsaServiceTrackingModelEventPlatform.android;
      case TargetPlatform.iOS:
        return GsaServiceTrackingModelEventPlatform.iOS;
      case TargetPlatform.macOS:
        return GsaServiceTrackingModelEventPlatform.macOS;
      case TargetPlatform.linux:
        return GsaServiceTrackingModelEventPlatform.linux;
      case TargetPlatform.windows:
        return GsaServiceTrackingModelEventPlatform.windows;
      default:
        throw UnimplementedError(
          'No event implementation made for platform $defaultTargetPlatform',
        );
    }
  }
}
