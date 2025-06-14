part of '../models.dart';

/// Identifiers for the supported currency types.
///
enum GsaModelPriceCurrencyType {
  /// The euro (symbol: €; code: EUR), official currency of 20 of the 27 member states of the European Union.
  ///
  eur,

  /// The United States dollar (symbol: $; code: USD), official currency of the United States and several other countries.
  ///
  usd,

  /// The yen (Japanese: 円, symbol: ¥; code: JPY) is the official currency of Japan.
  ///
  jpy;

  /// The symbol of the currency.
  ///
  String get symbol {
    switch (this) {
      case GsaModelPriceCurrencyType.eur:
        return '€';
      case GsaModelPriceCurrencyType.usd:
        return '\$';
      case GsaModelPriceCurrencyType.jpy:
        return '¥';
    }
  }

  /// User-visible display name for [this] currency.
  ///
  String get displayName {
    switch (this) {
      case GsaModelPriceCurrencyType.eur:
        return 'Euro ( $symbol )';
      case GsaModelPriceCurrencyType.usd:
        return 'US Dollar ( $symbol )';
      case GsaModelPriceCurrencyType.jpy:
        return 'Japanese Yen ( $symbol )';
    }
  }

  /// The international currency code.
  ///
  String get code {
    switch (this) {
      case GsaModelPriceCurrencyType.eur:
        return 'EUR';
      case GsaModelPriceCurrencyType.usd:
        return 'USD';
      case GsaModelPriceCurrencyType.jpy:
        return 'JPY';
    }
  }

  /// The given exchange factor in comparison to euro.
  ///
  /// For example, if 10 EUR equals 11 USD, the exchange factor will be 1.1,
  /// and this is the amount by which the given price will be multiplied.
  ///
  double get exchangeFactor {
    switch (this) {
      case GsaModelPriceCurrencyType.eur:
        return 1;
      case GsaModelPriceCurrencyType.usd:
        return 1.03;
      case GsaModelPriceCurrencyType.jpy:
        return 159.44;
    }
  }

  /// Converts an amount in centum from one currency to another.
  ///
  int convertCentum(
    GsaModelPriceCurrencyType other,
    int amount,
  ) {
    double amountInEur = amount / (exchangeFactor * 100);
    return (amountInEur * other.exchangeFactor * 100).round();
  }

  /// Converts an amount in whole units from one currency to another
  ///
  double convertUnity(
    GsaModelPriceCurrencyType other,
    double amount,
  ) {
    double amountInEur = amount / exchangeFactor;
    return amountInEur * other.exchangeFactor;
  }
}

/// A model class representing product price values.
///
@JsonSerializable(explicitToJson: true)
class GsaModelPrice extends _Model {
  // ignore: public_member_api_docs
  GsaModelPrice({
    super.id,
    super.originId,
    this.currencyType,
    this.centum,
    this.discount,
    this.clientVisible,
  });

  /// The type of the currency with which the price is denoted.
  ///
  GsaModelPriceCurrencyType? currencyType;

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
  static final conversionFactorNotifier = ValueNotifier<GsaModelPriceCurrencyType>(
    GsaModelPriceCurrencyType.eur,
  );

  /// Formatted price amount in EUR, or with an applied currency conersion factor.
  ///
  String? formatted() {
    if (centum == null) return null;
    return (currencyType != null && currencyType != conversionFactorNotifier.value
            ? currencyType!.convertUnity(conversionFactorNotifier.value, unity!).toStringAsFixed(2)
            : unity!.toStringAsFixed(2)) +
        ' ${conversionFactorNotifier.value.symbol}';
  }

  /// The discount applied to this price.
  ///
  GsaModelDiscount? discount;

  /// Promotional discount applied to this price.
  ///
  GsaModelPromotionalDiscount? promoDiscount;

  /// Whether the price should be visible to clients.
  ///
  bool? clientVisible;

  // ignore: public_member_api_docs
  factory GsaModelPrice.fromJson(Map json) {
    return _$GsaModelPriceFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelPriceToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelPrice.mock() {
    return GsaModelPrice(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      centum: _Model._generateRandomNumber(3),
      discount: null,
    );
  }
}

/// Class representing regular price discount values.
///
@JsonSerializable(explicitToJson: true)
class GsaModelDiscount extends _Model {
  // ignore: public_member_api_docs
  GsaModelDiscount({
    super.id,
    super.originId,
    super.categoryId,
    this.currencyType,
    this.centum,
    this.timeStartIso8601,
    this.timeEndIso8601,
    super.consentIds,
  });

  /// The type of the currency with which the price is denoted.
  ///
  GsaModelPriceCurrencyType? currencyType;

  /// The amount of discount in EUR cents.
  ///
  int? centum;

  /// The amount of discount in EUR.
  ///
  double? get unity => centum != null ? _Model._fromCentum(centum!) : null;

  /// Human-readable discount amount in EUR, or in any other currency with applied [conversionFactor].
  ///
  String? formatted() {
    if (centum == null) return null;
    return (currencyType != null && currencyType != GsaModelPrice.conversionFactorNotifier.value
            ? currencyType!.convertUnity(GsaModelPrice.conversionFactorNotifier.value, unity!).toStringAsFixed(2)
            : unity!.toStringAsFixed(2)) +
        ' ${GsaModelPrice.conversionFactorNotifier.value.symbol}';
  }

  /// The start time of when the discount is applicable in ISO 8601 format.
  ///
  String? timeStartIso8601;

  /// The end time of the discount validity in ISO 8601 format.
  ///
  String? timeEndIso8601;

  // ignore: public_member_api_docs
  factory GsaModelDiscount.fromJson(Map json) {
    return _$GsaModelDiscountFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelDiscountToJson(this);
  }
}

/// Class representing price promotional discount values.
///
/// Distinguished from [GsaModelDiscount] in that it does not represent a regular discount.
///
@JsonSerializable(explicitToJson: true)
class GsaModelPromotionalDiscount extends _Model {
  // ignore: public_member_api_docs
  GsaModelPromotionalDiscount({
    required super.id,
    required super.originId,
    required super.categoryId,
    required this.centum,
    required this.timeStartIso8601,
    required this.timeEndIso8601,
    super.consentIds,
  });

  /// The amount of discount expressed as 1/100.
  ///
  int? centum;

  /// The amount of discount expressed as 1/1.
  ///
  double? get unity => centum != null ? _Model._fromCentum(centum!) : null;

  /// Human-readable discount amount in EUR, or in any other currency with applied [conversionFactor].
  ///
  String? formatted([double? conversionFactor]) {
    return unity != null ? (conversionFactor != null ? (unity! * conversionFactor) : unity!).toStringAsFixed(2) : null;
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
  factory GsaModelPromotionalDiscount.fromJson(Map json) {
    return _$GsaModelPromotionalDiscountFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelPromotionalDiscountToJson(this);
  }
}
