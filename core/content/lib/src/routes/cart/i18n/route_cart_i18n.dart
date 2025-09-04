// ignore-for-file: public_member_api_docs

part of '../route_cart.dart';

enum GsaRouteCartI18N implements GsaServiceI18NBaseTranslations {
  cartItemEntryRemoveConfirmationDialogText(
    GsaServiceI18NModelTranslatedValue(
      'Remove this item from cart?',
      enIe: 'Remove this item from cart?',
      enGb: 'Remove this item from cart?',
      de: 'Diesen Artikel aus dem Warenkorb entfernen?',
      it: 'Rimuovere questo articolo dal carrello?',
      fr: 'Supprimer cet article du panier ?',
      es: '¿Eliminar este artículo del carrito?',
      hr: 'Ukloniti ovaj artikl iz košarice?',
      cz: 'Odebrat tuto položku z košíku?',
    ),
  ),
  cartItemEntrySizeLabel(
    GsaServiceI18NModelTranslatedValue(
      'Size',
      enIe: 'Size',
      enGb: 'Size',
      de: 'Größe',
      it: 'Taglia',
      fr: 'Taille',
      es: 'Talla',
      hr: 'Veličina',
      cz: 'Velikost',
    ),
  );

  const GsaRouteCartI18N(this.value);

  @override
  final GsaServiceI18NModelTranslatedValue value;
}
