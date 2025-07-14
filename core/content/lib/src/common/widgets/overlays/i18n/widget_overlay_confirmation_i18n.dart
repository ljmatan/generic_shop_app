// ignore_for_file: public_member_api_docs

part of '../widget_overlay_confirmation.dart';

enum GsaWidgetOverlayConfirmationI18N implements GsaServiceI18NBaseTranslations {
  message(
    GsaServiceI18NModelTranslatedValue(
      'Confirm?',
      enIe: 'Confirm?',
      enGb: 'Confirm?',
      de: 'Bestätigen?',
      it: 'Confermare?',
      fr: 'Confirmer?',
      es: '¿Confirmar?',
      hr: 'Potvrditi?',
      cz: 'Potvrdit?',
    ),
  ),
  cancelButtonLabel(
    GsaServiceI18NModelTranslatedValue(
      'NO',
      enIe: 'NO',
      enGb: 'NO',
      de: 'NEIN',
      it: 'NO',
      fr: 'NON',
      es: 'NO',
      hr: 'NE',
      cz: 'NE',
    ),
  ),
  confirmButtonLabel(
    GsaServiceI18NModelTranslatedValue(
      'YES',
      enIe: 'YES',
      enGb: 'YES',
      de: 'JA',
      it: 'SÌ',
      fr: 'OUI',
      es: 'SÍ',
      hr: 'DA',
      cz: 'ANO',
    ),
  );

  const GsaWidgetOverlayConfirmationI18N(this.value);

  @override
  final GsaServiceI18NModelTranslatedValue value;
}
