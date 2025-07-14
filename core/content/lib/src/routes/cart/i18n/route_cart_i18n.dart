// ignore_for_file: public_member_api_docs

part of '../route_cart.dart';

enum GsaRouteCartI18N implements GsaServiceI18NBaseTranslations {
  cartItemEntryRemoveConfirmationDialogText(
    GsaServiceI18NModelTranslatedValue(
      'Remove this item from cart?',
      enIe: 'Remove this item from cart?',
      enGb: 'Remove this item from cart?',
      de: 'Remove this item from cart?',
      it: 'Remove this item from cart?',
      fr: 'Remove this item from cart?',
      es: 'Remove this item from cart?',
      hr: 'Remove this item from cart?',
      cz: 'Remove this item from cart?',
    ),
  ),
  cartItemEntrySizeLabel(
    GsaServiceI18NModelTranslatedValue(
      'Size',
      enIe: 'Size',
      enGb: 'Size',
      de: 'Size',
      it: 'Size',
      fr: 'Size',
      es: 'Size',
      hr: 'Size',
      cz: 'Size',
    ),
  );

  const GsaRouteCartI18N(this.value);

  @override
  final GsaServiceI18NModelTranslatedValue value;
}
