// ignore_for_file: public_member_api_docs

part of '../route_camera.dart';

enum GsaRouteCameraI18N implements GsaServiceI18NBaseTranslations {
  saleItemNotFoundAlertMessage(
    GsaServiceI18NModelTranslatedValue(
      'Sale item not found',
      enIe: 'Sale item not found',
      enGb: 'Sale item not found',
      de: 'Verkaufsartikel nicht gefunden',
      it: 'Articolo in vendita non trovato',
      fr: 'Article en vente non trouvé',
      es: 'Artículo en venta no encontrado',
      hr: 'Prodajna stavka nije pronađena',
      cz: 'Prodejní položka nebyla nalezena',
    ),
  ),
  saleItemAlreadyAddedAlertMessage(
    GsaServiceI18NModelTranslatedValue(
      'Sale item already in cart',
      enIe: 'Sale item already in cart',
      enGb: 'Sale item already in cart',
      de: 'Artikel bereits im Warenkorb',
      it: 'Articolo già nel carrello',
      fr: 'Article déjà dans le panier',
      es: 'Artículo ya en el carrito',
      hr: 'Artikl je već u košarici',
      cz: 'Položka je již v košíku',
    ),
  );

  const GsaRouteCameraI18N(this.value);

  @override
  final GsaServiceI18NModelTranslatedValue value;
}
