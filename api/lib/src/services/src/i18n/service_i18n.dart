import 'package:generic_shop_app_api/src/services/services.dart';

part 'values/service_i18n_values.dart';
part 'values/service_i18n_values_route.dart';
part 'values/service_i18n_values_route_auth.dart';
part 'values/service_i18n_values_route_cart.dart';
part 'values/service_i18n_values_route_checkout.dart';
part 'values/service_i18n_values_route_debug.dart';
part 'values/service_i18n_values_route_guest_info.dart';
part 'values/service_i18n_values_route_help.dart';
part 'values/service_i18n_values_route_licences.dart';
part 'values/service_i18n_values_route_merchant.dart';
part 'values/service_i18n_values_route_payment_status.dart';
part 'values/service_i18n_values_route_privacy_policy.dart';
part 'values/service_i18n_values_route_product_details.dart';
part 'values/service_i18n_values_route_settings.dart';
part 'values/service_i18n_values_route_shop.dart';
part 'values/service_i18n_values_route_terms_and_conditions.dart';

/// Central access point for the internationalization services.
///
class GsaaServiceI18N extends GsaaService {
  GsaaServiceI18N._();

  static final _instance = GsaaServiceI18N._();

  // ignore: public_member_api_docs
  static GsaaServiceI18N get instance => _instance() as GsaaServiceI18N;

  /// The specified runtime display language.
  ///
  static GsaaServiceI18NLanguage language = GsaaServiceI18NLanguage.en;
}

/// Unique language identifiers.
///
enum GsaaServiceI18NLanguage {
  /// English (US) language.
  ///
  en,

  /// German language.
  ///
  de,

  /// French language.
  ///
  fr,

  /// Spanish language.
  ///
  es,

  /// Croatian language.
  hr,
}

/// Extension methods for the language identifiers.
///
extension GsaaServiceI18NLanguageExt on GsaaServiceI18NLanguage {
  /// Currency display name visible to the user.
  ///
  String get displayName {
    switch (this) {
      case GsaaServiceI18NLanguage.en:
        return 'English';
      case GsaaServiceI18NLanguage.de:
        return 'Deutsch';
      case GsaaServiceI18NLanguage.fr:
        return 'French';
      case GsaaServiceI18NLanguage.es:
        return 'Spanish';
      case GsaaServiceI18NLanguage.hr:
        return 'Croatian';
    }
  }
}

/// Internationalization extension methods for [String] type objects.
///
extension GsaaServiceI18NStringExt on String {
  /// The default method for translating strings, identified by the given [parentRoute] object.
  ///
  String translatedFromType(Type parentRoute) {
    if (GsaaServiceI18N.language == GsaaServiceI18NLanguage.en) return this;
    String? translatedValue = _values[parentRoute]?[this]?[GsaaServiceI18N.language];
    translatedValue ??= _values['GsaRoute']?[this]?[GsaaServiceI18N.language];
    if (translatedValue == null || translatedValue.isEmpty) {
      GsaaServiceLogging.logError(
        '${GsaaServiceI18N.language} $this not translated with $parentRoute.',
      );
      return this;
    } else {
      return translatedValue;
    }
  }
}
