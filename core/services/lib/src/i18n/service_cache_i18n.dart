// ignore_for_file: public_member_api_docs

part of '../modules/cache/service_cache.dart';

enum GsaServiceCacheI18N implements GsaServiceI18NBaseTranslations {
  invalidVersionErrorMessage(
    GsaServiceI18NModelTranslatedValue(
      'Invalid cache manager version',
      enIe: 'Invalid cache manager version',
      enGb: 'Invalid cache manager version',
      de: 'Ungültige Cache-Manager-Version',
      it: 'Versione non valida Cache Manager',
      fr: 'Version du gestionnaire de cache non valide',
      es: 'Versión no válida del administrador de caché',
      hr: 'Nevažeća verzija upravitelja predmemorije',
      cz: 'Neplatná verze správce mezipaměti',
    ),
  ),
  version(
    GsaServiceI18NModelTranslatedValue(
      'Cache Service Version',
      enIe: 'Cache Service Version',
      enGb: 'Cache Service Version',
      de: 'Cache-Service-Version',
      it: 'Versione del servizio Cache',
      fr: 'Version du service de cache',
      es: 'Versión de servicio de caché',
      hr: 'Verzija usluge predmemorije',
      cz: 'Verze služby mezipaměti',
    ),
  ),
  translations(
    GsaServiceI18NModelTranslatedValue(
      'Translation Values',
      enIe: 'Translation Values',
      enGb: 'Translation Values',
      de: 'Übersetzungswerte',
      it: 'Valori di traduzione',
      fr: 'Valeurs de traduction',
      es: 'Valores de traducción',
      hr: 'Vrijednosti prijevoda',
      cz: 'Hodnoty překladu',
    ),
  ),
  cookieConsentMandatory(
    GsaServiceI18NModelTranslatedValue(
      'Mandatory Cookies',
      enIe: 'Mandatory Cookies',
      enGb: 'Mandatory Cookies',
      de: 'Obligatorische Kekse',
      it: 'Biscotti obbligatori',
      fr: 'Cookies obligatoires',
      es: 'Galletas obligatorias',
      hr: 'Obavezni kolačići',
      cz: 'Povinné cookies',
    ),
  ),
  cookieConsentFunctional(
    GsaServiceI18NModelTranslatedValue(
      'Functional Cookies',
      enIe: 'Functional Cookies',
      enGb: 'Functional Cookies',
      de: 'Funktionelle Cookies',
      it: 'Cookie funzionali',
      fr: 'Cookies fonctionnels',
      es: 'Cookies funcionales',
      hr: 'Funkcionalni kolačići',
      cz: 'Funkční cookies',
    ),
  ),
  cookieConsentStatistical(
    GsaServiceI18NModelTranslatedValue(
      'Statistical Cookies',
      enIe: 'Statistical Cookies',
      enGb: 'Statistical Cookies',
      de: 'Statistische Kekse',
      it: 'Cookie statistiche',
      fr: 'Cookies statistiques',
      es: 'Galletas estadísticas',
      hr: 'Statistički kolačići',
      cz: 'Statistické soubory cookie',
    ),
  ),
  cookieConsentMarketing(
    GsaServiceI18NModelTranslatedValue(
      'Marketing Cookies',
      enIe: 'Marketing Cookies',
      enGb: 'Marketing Cookies',
      de: 'marketingCookies',
      it: 'Cookie di marketing',
      fr: 'Cookies marketing',
      es: 'Cookies de marketing',
      hr: 'Marketinški kolačići',
      cz: 'Marketingové cookies',
    ),
  ),
  authenticationToken(
    GsaServiceI18NModelTranslatedValue(
      'Authentication Token',
      enIe: 'Authentication Token',
      enGb: 'Authentication Token',
      de: 'Authentifizierungs -Token',
      it: 'Token di autenticazione',
      fr: 'Jeton d\'authentification',
      es: 'Token de autenticación',
      hr: 'Token za provjeru autentičnosti',
      cz: 'Autentizační token',
    ),
  ),
  guestUserEncodedData(
    GsaServiceI18NModelTranslatedValue(
      'Guest User Data',
      enIe: 'Guest User Data',
      enGb: 'Guest User Data',
      de: 'Gastbenutzerdaten',
      it: 'Dati dell\'utente ospite',
      fr: 'Données des utilisateurs invités',
      es: 'Datos de usuario invitado',
      hr: 'Podaci o korisniku gostiju',
      cz: 'Uživatelská data hosta',
    ),
  ),
  bookmarks(
    GsaServiceI18NModelTranslatedValue(
      'Bookmarks',
      enIe: 'Bookmarks',
      enGb: 'Bookmarks',
      de: 'Lesezeichen',
      it: 'Segnalibri',
      fr: 'Signets',
      es: 'Marcadores',
      hr: 'Oznake',
      cz: 'Záložky',
    ),
  ),
  shopSearchHistory(
    GsaServiceI18NModelTranslatedValue(
      'Shop Search History',
      enIe: 'Shop Search History',
      enGb: 'Shop Search History',
      de: 'Laden Sie die Suche nach Suchgeschichte',
      it: 'Storia della ricerca del negozio',
      fr: 'Historique de recherche de magasins',
      es: 'Historial de búsqueda de tiendas',
      hr: 'Povijest pretraživanja trgovine',
      cz: 'Historie vyhledávání obchodů',
    ),
  ),
  themeBrightness(
    GsaServiceI18NModelTranslatedValue(
      'Theme Brightness',
      enIe: 'Theme Brightness',
      enGb: 'Theme Brightness',
      de: 'Thema Helligkeit',
      it: 'Luminosità del tema',
      fr: 'Luminosité du thème',
      es: 'Brillo del tema',
      hr: 'Svjetlina teme',
      cz: 'Jas motivy',
    ),
  );

  const GsaServiceCacheI18N(
    this.value,
  );

  @override
  final GsaServiceI18NModelTranslatedValue value;
}
