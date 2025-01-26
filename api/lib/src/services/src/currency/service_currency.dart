import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:json_annotation/json_annotation.dart' as json_annotation;

/// Service implementing several useful methods and properties for currency management.
///
class GsaaServiceCurrency extends GsarService {
  GsaaServiceCurrency._();

  static final _instance = GsaaServiceCurrency._();

  // ignore: public_member_api_docs
  static GsaaServiceCurrency get instance => _instance() as GsaaServiceCurrency;

  /// The specified runtime display language.
  ///
  static GsaaServiceCurrencyType currency = GsaaServiceCurrencyType.eur;
}

/// Identifiers for the supported currency types.
///
enum GsaaServiceCurrencyType {
  /// The euro (symbol: €; code: EUR), official currency of 20 of the 27 member states of the European Union.
  ///
  @json_annotation.JsonValue('eur')
  eur,

  /// The United States dollar (symbol: $; code: USD), official currency of the United States and several other countries.
  ///
  @json_annotation.JsonValue('usd')
  usd,

  /// The yen (Japanese: 円, symbol: ¥; code: JPY) is the official currency of Japan.
  ///
  @json_annotation.JsonValue('jpy')
  jpy,
}

/// Extension properties and methods for the supported currency types, with focus on display services.
///
extension GsaaServiceCurrencyTypeExt on GsaaServiceCurrencyType {
  /// User-visible display name for [this] currency.
  ///
  String get displayName {
    switch (this) {
      case GsaaServiceCurrencyType.eur:
        return 'Euro ( € )';
      case GsaaServiceCurrencyType.usd:
        return 'US Dollar ( \$ )';
      case GsaaServiceCurrencyType.jpy:
        return 'Japanese Yen ( ¥ )';
    }
  }

  /// The international currency code.
  ///
  String get code {
    switch (this) {
      case GsaaServiceCurrencyType.eur:
        return 'EUR';
      case GsaaServiceCurrencyType.usd:
        return 'USD';
      case GsaaServiceCurrencyType.jpy:
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
      case GsaaServiceCurrencyType.eur:
        return 1;
      case GsaaServiceCurrencyType.usd:
        return 1.1;
      case GsaaServiceCurrencyType.jpy:
        return 160;
    }
  }
}
