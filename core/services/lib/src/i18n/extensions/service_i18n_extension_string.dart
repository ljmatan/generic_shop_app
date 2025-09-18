part of '../service_i18n.dart';

extension GsaServiceI18NString on String {
  String translate(BuildContext context) {
    final translationReference = GsaServiceI18N.instance.getTranslationReference(context);
    if (translationReference == null) {
      return this;
    }
    if (translationReference.route?.translatable != false) {
      return GsaServiceI18N.instance.translate(
            ancestor: translationReference.ancestor,
            route: translationReference.route.runtimeType,
            value: this,
          ) ??
          this;
    }
    return this;
  }

  String translateFromType({
    required Type ancestor,
    GsaRoute? route,
  }) {
    return GsaServiceI18N.instance.translate(
          ancestor: ancestor,
          route: route.runtimeType,
          value: this,
        ) ??
        this;
  }
}
