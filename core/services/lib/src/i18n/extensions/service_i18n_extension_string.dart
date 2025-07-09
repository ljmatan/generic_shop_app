part of '../service_i18n.dart';

extension GsaServiceI18NString on String {
  String translate(BuildContext context) {
    final translationReference = GsaServiceI18N.instance.getTranslationReference(context);
    if (translationReference == null) {
      return this;
    }
    return GsaServiceI18N.instance.translate(
          ancestor: translationReference,
          value: this,
        ) ??
        this;
  }
}
