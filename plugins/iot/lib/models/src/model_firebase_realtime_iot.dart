class ModelGiotFirebaseDatabaseStatus {
  num? temperature, humidity;

  ModelGiotFirebaseDatabaseStatus({
    this.temperature,
    this.humidity,
  });

  factory ModelGiotFirebaseDatabaseStatus.fromJson(Map<String, dynamic> json) => ModelGiotFirebaseDatabaseStatus(
        temperature: num.tryParse(
          json['temperature'].toString(),
        ),
        humidity: num.tryParse(
          json['humidity'].toString(),
        ),
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidity": humidity,
      };
}

class ModelGiotFirebaseDatabaseHeating {
  ModelGiotFirebaseDatabaseHeatingRules? rules;

  ModelGiotFirebaseDatabaseHeating({
    this.rules,
  });

  factory ModelGiotFirebaseDatabaseHeating.fromJson(Map<String, dynamic> json) => ModelGiotFirebaseDatabaseHeating(
        rules: json["rules"] == null ? null : ModelGiotFirebaseDatabaseHeatingRules.fromJson(json["rules"]),
      );

  Map<String, dynamic> toJson() => {
        "rules": rules?.toJson(),
      };
}

class ModelGiotFirebaseDatabaseHeatingRules {
  int? maxTimeOnHourly;
  int? minTemperature;

  ModelGiotFirebaseDatabaseHeatingRules({
    this.maxTimeOnHourly,
    this.minTemperature,
  });

  factory ModelGiotFirebaseDatabaseHeatingRules.fromJson(Map<String, dynamic> json) => ModelGiotFirebaseDatabaseHeatingRules(
        maxTimeOnHourly: json["max_time_on_hourly"],
        minTemperature: json["min_temperature"],
      );

  Map<String, dynamic> toJson() => {
        "max_time_on_hourly": maxTimeOnHourly,
        "min_temperature": minTemperature,
      };
}

class ModelGiotFirebaseDatabaseIrrigation {
  ModelGiotFirebaseDatabaseIrrigationRules? rules;

  ModelGiotFirebaseDatabaseIrrigation({
    this.rules,
  });

  factory ModelGiotFirebaseDatabaseIrrigation.fromJson(Map<String, dynamic> json) => ModelGiotFirebaseDatabaseIrrigation(
        rules: json["rules"] == null ? null : ModelGiotFirebaseDatabaseIrrigationRules.fromJson(json["rules"]),
      );

  Map<String, dynamic> toJson() => {
        "rules": rules?.toJson(),
      };
}

class ModelGiotFirebaseDatabaseIrrigationRules {
  int? cycleRepeatTime;
  int? cycleTimeOffsetMinutes;
  int? cycleTimeSeconds;
  int? pauseTimeSeconds;
  bool? enabled;

  ModelGiotFirebaseDatabaseIrrigationRules({
    this.cycleRepeatTime,
    this.cycleTimeOffsetMinutes,
    this.cycleTimeSeconds,
    this.pauseTimeSeconds,
    this.enabled,
  });

  factory ModelGiotFirebaseDatabaseIrrigationRules.fromJson(Map<String, dynamic> json) => ModelGiotFirebaseDatabaseIrrigationRules(
        cycleRepeatTime: json["cycle_repeat_time"],
        cycleTimeOffsetMinutes: json["cycle_time_offset_minutes"],
        cycleTimeSeconds: json["cycle_time_seconds"],
        pauseTimeSeconds: json["pause_time_seconds"],
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "cycle_repeat_time": cycleRepeatTime,
        "cycle_time_offset_minutes": cycleTimeOffsetMinutes,
        "cycle_time_seconds": cycleTimeSeconds,
        "pause_time_seconds": pauseTimeSeconds,
        "enabled": enabled,
      };
}

class ModelGiotFirebaseDatabaseLights {
  ModelGiotFirebaseDatabaseLightsRules? rules;

  ModelGiotFirebaseDatabaseLights({
    this.rules,
  });

  factory ModelGiotFirebaseDatabaseLights.fromJson(Map<String, dynamic> json) => ModelGiotFirebaseDatabaseLights(
        rules: json["rules"] == null ? null : ModelGiotFirebaseDatabaseLightsRules.fromJson(json["rules"]),
      );

  Map<String, dynamic> toJson() => {
        "rules": rules?.toJson(),
      };
}

class ModelGiotFirebaseDatabaseLightsRules {
  int? dailyOnTimeHours;

  ModelGiotFirebaseDatabaseLightsRules({
    this.dailyOnTimeHours,
  });

  factory ModelGiotFirebaseDatabaseLightsRules.fromJson(Map<String, dynamic> json) => ModelGiotFirebaseDatabaseLightsRules(
        dailyOnTimeHours: json["daily_on_time_hours"],
      );

  Map<String, dynamic> toJson() => {
        "daily_on_time_hours": dailyOnTimeHours,
      };
}

class ModelGiotFirebaseDatabaseVentilation {
  ModelGiotFirebaseDatabaseVentilationRules? rules;

  ModelGiotFirebaseDatabaseVentilation({
    this.rules,
  });

  factory ModelGiotFirebaseDatabaseVentilation.fromJson(Map<String, dynamic> json) => ModelGiotFirebaseDatabaseVentilation(
        rules: json["rules"] == null ? null : ModelGiotFirebaseDatabaseVentilationRules.fromJson(json["rules"]),
      );

  Map<String, dynamic> toJson() => {
        "rules": rules?.toJson(),
      };
}

class ModelGiotFirebaseDatabaseVentilationRules {
  int? cycleRepeatTime;
  int? cycleTimeOffsetMinutes;
  int? cycleTimeSeconds;
  int? pauseTimeSeconds;

  ModelGiotFirebaseDatabaseVentilationRules({
    this.cycleRepeatTime,
    this.cycleTimeOffsetMinutes,
    this.cycleTimeSeconds,
    this.pauseTimeSeconds,
  });

  factory ModelGiotFirebaseDatabaseVentilationRules.fromJson(Map<String, dynamic> json) => ModelGiotFirebaseDatabaseVentilationRules(
        cycleRepeatTime: json["cycle_repeat_time"],
        cycleTimeOffsetMinutes: json["cycle_time_offset_minutes"],
        cycleTimeSeconds: json["cycle_time_seconds"],
        pauseTimeSeconds: json["pause_time_seconds"],
      );

  Map<String, dynamic> toJson() => {
        "cycle_repeat_time": cycleRepeatTime,
        "cycle_time_offset_minutes": cycleTimeOffsetMinutes,
        "cycle_time_seconds": cycleTimeSeconds,
        "pause_time_seconds": pauseTimeSeconds,
      };
}
