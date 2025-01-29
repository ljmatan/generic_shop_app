import 'package:generic_shop_app_architecture/gsar.dart';

/// A model class representing product price values.
///
@GsarModelMacro()
class GsaaModelPrice {
  // ignore: public_member_api_docs
  GsaaModelPrice({
    this.originalPriceCentum,
    this.originalPriceId,
    required this.eurCents,
    this.discount,
    this.clientVisible,
  });

  /// The value of original (source) price in centum (1 / 100).
  ///
  int? originalPriceCentum;

  /// Identifier for the given original (source) price.
  ///
  String? originalPriceId;

  /// The price amount in EUR cents.
  ///
  int? eurCents;

  /// The price amount in EUR.
  ///
  double? get eur {
    return eurCents != null ? GsaaModelPrice._fromCentum(eurCents!) : null;
  }

  /// Conversion factor applied to the [formatted] method for price display.
  ///
  static double? conversionFactor;

  /// Formatted price amount in EUR, or with an applied currency conersion factor.
  ///
  String? formatted() {
    return eur != null ? (conversionFactor != null ? (eur! * conversionFactor!) : eur!).toStringAsFixed(2) : null;
  }

  /// The discount applied to this price.
  ///
  GsaaModelPriceDiscount? discount;

  /// Whether the price should be visible to clients.
  ///
  bool? clientVisible;

  static double _fromCentum(int value) {
    return double.parse((value / 100).toStringAsFixed(2));
  }
}

/// Class representing regular price discount values.
///
@GsarModelMacro()
class GsaaModelPriceDiscount {
  // ignore: public_member_api_docs
  GsaaModelPriceDiscount({
    required this.eurCents,
    required this.timeStartIso8601,
    required this.timeEndIso8601,
  });

  /// The amount of discount in EUR cents.
  ///
  int? eurCents;

  /// The amount of discount in EUR.
  ///
  double? get eur => eurCents != null ? GsaaModelPrice._fromCentum(eurCents!) : null;

  /// Human-readable discount amount in EUR, or in any other currency with applied [conversionFactor].
  ///
  String? formatted() {
    return eur != null
        ? (GsaaModelPrice.conversionFactor != null ? (eur! * GsaaModelPrice.conversionFactor!) : eur!).toStringAsFixed(2)
        : null;
  }

  /// The start time of when the discount is applicable in ISO 8601 format.
  ///
  String? timeStartIso8601;

  /// The end time of the discount validity in ISO 8601 format.
  ///
  String? timeEndIso8601;
}
