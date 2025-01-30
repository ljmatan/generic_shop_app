part of '../models.dart';

/// A model class representing product price values.
///
@JsonSerializable(explicitToJson: true)
class GsaaModelPrice extends _Model {
  // ignore: public_member_api_docs
  GsaaModelPrice({
    super.id,
    super.originId,
    this.originalPriceCentum,
    this.originalPriceId,
    this.centum,
    this.discount,
    this.clientVisible,
  });

  /// The value of original (source) price in centum (1 / 100).
  ///
  int? originalPriceCentum;

  /// Identifier for the given original (source) price.
  ///
  String? originalPriceId;

  /// Price denoted at 1/100 (e.g., euro cents).
  ///
  int? centum;

  /// Price denoted at 1/1 (e.g., euros).
  ///
  double? get unity {
    return centum != null ? _Model._fromCentum(centum!) : null;
  }

  /// Conversion factor applied to the [formatted] method for price display.
  ///
  static double? conversionFactor;

  /// Formatted price amount in EUR, or with an applied currency conersion factor.
  ///
  String? formatted() {
    return unity != null ? (conversionFactor != null ? (unity! * conversionFactor!) : unity!).toStringAsFixed(2) : null;
  }

  /// The discount applied to this price.
  ///
  GsaaModelDiscount? discount;

  /// Promotional discount applied to this price.
  ///
  GsaaModelPromotionalDiscount? promoDiscount;

  /// Whether the price should be visible to clients.
  ///
  bool? clientVisible;

  // ignore: public_member_api_docs
  factory GsaaModelPrice.fromJson(Map json) {
    return _$GsaaModelPriceFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelPriceToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaaModelPrice.mock() {
    return GsaaModelPrice(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      originalPriceCentum: null,
      originalPriceId: null,
      centum: _Model._generateRandomNumber(3),
      discount: null,
    );
  }
}

/// Class representing regular price discount values.
///
@JsonSerializable(explicitToJson: true)
class GsaaModelDiscount extends _Model {
  // ignore: public_member_api_docs
  GsaaModelDiscount({
    super.id,
    super.originId,
    super.categoryId,
    this.centum,
    this.timeStartIso8601,
    this.timeEndIso8601,
    super.consentIds,
  });

  /// The amount of discount in EUR cents.
  ///
  int? centum;

  /// The amount of discount in EUR.
  ///
  double? get unity => centum != null ? _Model._fromCentum(centum!) : null;

  /// Human-readable discount amount in EUR, or in any other currency with applied [conversionFactor].
  ///
  String? formatted() {
    return centum != null
        ? (GsaaModelPrice.conversionFactor != null ? (centum! * GsaaModelPrice.conversionFactor!) : centum!).toStringAsFixed(2)
        : null;
  }

  /// The start time of when the discount is applicable in ISO 8601 format.
  ///
  String? timeStartIso8601;

  /// The end time of the discount validity in ISO 8601 format.
  ///
  String? timeEndIso8601;

  // ignore: public_member_api_docs
  factory GsaaModelDiscount.fromJson(Map json) {
    return _$GsaaModelDiscountFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelDiscountToJson(this);
  }
}

/// Class representing price promotional discount values.
///
/// Distinguished from [GsaaModelDiscount] in that it does not represent a regular discount.
///
@JsonSerializable(explicitToJson: true)
class GsaaModelPromotionalDiscount extends _Model {
  // ignore: public_member_api_docs
  GsaaModelPromotionalDiscount({
    required super.id,
    required super.originId,
    required super.categoryId,
    required this.eurCents,
    required this.timeStartIso8601,
    required this.timeEndIso8601,
    super.consentIds,
  });

  /// The amount of discount in EUR cents.
  ///
  int? eurCents;

  /// The amount of discount in EUR.
  ///
  double? get eur => eurCents != null ? _Model._fromCentum(eurCents!) : null;

  /// Human-readable discount amount in EUR, or in any other currency with applied [conversionFactor].
  ///
  String? formatted([double? conversionFactor]) {
    return eur != null ? (conversionFactor != null ? (eur! * conversionFactor) : eur!).toStringAsFixed(2) : null;
  }

  /// The start time of when the discount is applicable in ISO 8601 format.
  ///
  String? timeStartIso8601;

  /// The end time of the discount validity in ISO 8601 format.
  ///
  String? timeEndIso8601;

  /// Coupon code associated with the discount.
  ///
  String? couponCode;

  // ignore: public_member_api_docs
  factory GsaaModelPromotionalDiscount.fromJson(Map json) {
    return _$GsaaModelPromotionalDiscountFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelPromotionalDiscountToJson(this);
  }
}
