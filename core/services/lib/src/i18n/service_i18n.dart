import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_services/services.dart';

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
class GsaServiceI18N extends GsaService {
  GsaServiceI18N._();

  static final _instance = GsaServiceI18N._();

  // ignore: public_member_api_docs
  static GsaServiceI18N get instance => _instance() as GsaServiceI18N;

  /// The specified runtime display language.
  ///
  static GsaServiceI18NLanguage language = GsaServiceI18NLanguage.en;
}

/// Unique language identifiers.
///
enum GsaServiceI18NLanguage {
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
extension GsaServiceI18NLanguageExt on GsaServiceI18NLanguage {
  /// Currency display name visible to the user.
  ///
  String get displayName {
    switch (this) {
      case GsaServiceI18NLanguage.en:
        return 'English';
      case GsaServiceI18NLanguage.de:
        return 'Deutsch';
      case GsaServiceI18NLanguage.fr:
        return 'French';
      case GsaServiceI18NLanguage.es:
        return 'Spanish';
      case GsaServiceI18NLanguage.hr:
        return 'Croatian';
    }
  }
}

/// Internationalization extension methods for [String] type objects.
///
extension GsaServiceI18NStringExt on String {
  /// The default method for translating strings, identified by the given [parentRoute] object.
  ///
  String translatedFromType(Type parentRoute) {
    if (GsaServiceI18N.language == GsaServiceI18NLanguage.en) return this;
    String? translatedValue = _values[parentRoute]?[this]?[GsaServiceI18N.language];
    translatedValue ??= _values['GsaRoute']?[this]?[GsaServiceI18N.language];
    if (translatedValue == null || translatedValue.isEmpty) {
      GsaServiceLogging.instance.logError(
        '${GsaServiceI18N.language} $this not translated with $parentRoute.',
      );
      return this;
    } else {
      return translatedValue;
    }
  }
}

extension GsaServiceI18nExt on String {
  ///
  ///
  String translated(BuildContext context) {
    Type? routeType = context.findAncestorStateOfType<GsaRouteState>()?.widget.runtimeType;
    routeType ??= context.widget.runtimeType;
    return translatedFromType(routeType);
  }
}
