part of '../models.dart';

/// Model class specifying the parameters for any applicable client consent (terms and conditions).
///
@JsonSerializable(explicitToJson: true)
class GsaModelConsent extends _Model {
  // ignore: public_member_api_docs
  GsaModelConsent({
    required super.id,
    required super.originId,
    required this.version,
    required this.text,
    required this.publishTimeIso8601,
    required this.deadlineTimeIso8601,
    required this.consented,
    required this.acknowledged,
    required this.requisite,
    required super.originUrl,
  });

  /// Version identifier for [this] consent instance.
  ///
  final String? version;

  /// Complete text of the legal notice.
  ///
  final String? text;

  /// The time of publishing of the consent in ISO 8601 [String] format.
  ///
  final String? publishTimeIso8601;

  /// The time of publishing of the consent in [DateTime] format.
  ///
  DateTime? get publishTime => publishTimeIso8601 != null ? DateTime.tryParse(publishTimeIso8601!) : null;

  /// The deadline by which this consent status must be updated in ISO 8601 [String] format.
  ///
  final String? deadlineTimeIso8601;

  /// The deadline by which this consent status must be updated in [DateTime] format.
  ///
  DateTime? get deadlineTime => deadlineTimeIso8601 != null ? DateTime.tryParse(deadlineTimeIso8601!) : null;

  /// Information verifying the given entity has confirmed [this] consent.
  ///
  /// Values:
  ///
  /// - `true`: consent specified as given
  /// - `false`: consent specified as declined
  /// - `null`: consent not specified
  ///
  final bool? consented;

  /// Whether the user has acknowledged the receipt of the consent notice.
  ///
  /// Values:
  ///
  /// - `true`: the user has acknowledged the consent receipt
  /// - `false`: the user has declined the receipt acknowledgement
  /// - `null`: the user has not acknowledged the consent
  ///
  final bool? acknowledged;

  /// Determines whether the consent is required.
  ///
  /// Values:
  ///
  /// - `true`: the consent is marked as required
  /// - `false`: the consent is marked as optional
  /// - `null`: no consent requirement status
  ///
  final bool? requisite;

  // ignore: public_member_api_docs
  factory GsaModelConsent.fromJson(Map json) {
    return _$GsaModelConsentFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelConsentToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelConsent.mock() {
    return GsaModelConsent(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      version: _Model._generateRandomString(8),
      text: _Model._generateRandomString(300),
      publishTimeIso8601: DateTime.now().subtract(const Duration(hours: 24)).toIso8601String(),
      deadlineTimeIso8601: DateTime.now().subtract(const Duration(hours: 24)).toIso8601String(),
      consented: Random().nextBool() ? Random().nextBool() : null,
      acknowledged: null,
      requisite: Random().nextBool(),
      originUrl: 'https://wikipedia.org',
    );
  }
}
