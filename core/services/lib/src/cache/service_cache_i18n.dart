// ignore_for_file: public_member_api_docs

part of 'service_cache.dart';

enum GsaServiceCacheI18N implements GsaServiceI18NBaseTranslations {
  _invalidVersionErrorMessage(
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
  _version(
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
  _deviceId(
    GsaServiceI18NModelTranslatedValue(
      'Device Identifier',
      enIe: 'Device Identifier',
      enGb: 'Device Identifier',
      de: 'Gerätekennung',
      it: 'Identificativo dispositivo',
      fr: 'Identifiant de l\'appareil',
      es: 'Identificador de dispositivo',
      hr: 'Identifikator uređaja',
      cz: 'Identifikátor zařízení',
    ),
  ),
  _translations(
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
  _cookieConsentMandatory(
    GsaServiceI18NModelTranslatedValue(
      'Mandatory Cookies',
      enIe: 'Mandatory Cookies',
      enGb: 'Mandatory Cookies',
      de: 'Obligatorische Cookies',
      it: 'Biscotti obbligatori',
      fr: 'Cookies obligatoires',
      es: 'Galletas obligatorias',
      hr: 'Obavezni kolačići',
      cz: 'Povinné cookies',
    ),
  ),
  _cookieConsentFunctional(
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
  _cookieConsentStatistical(
    GsaServiceI18NModelTranslatedValue(
      'Statistical Cookies',
      enIe: 'Statistical Cookies',
      enGb: 'Statistical Cookies',
      de: 'Statistische Cookies',
      it: 'Cookie statistiche',
      fr: 'Cookies statistiques',
      es: 'Galletas estadísticas',
      hr: 'Statistički kolačići',
      cz: 'Statistické soubory cookie',
    ),
  ),
  _cookieConsentMarketing(
    GsaServiceI18NModelTranslatedValue(
      'Marketing Cookies',
      enIe: 'Marketing Cookies',
      enGb: 'Marketing Cookies',
      de: 'MarketingCookies',
      it: 'Cookie di marketing',
      fr: 'Cookies marketing',
      es: 'Cookies de marketing',
      hr: 'Marketinški kolačići',
      cz: 'Marketingové cookies',
    ),
  ),
  _authenticationToken(
    GsaServiceI18NModelTranslatedValue(
      'Authentication Token',
      enIe: 'Authentication Token',
      enGb: 'Authentication Token',
      de: 'Authentifizierungs-Token',
      it: 'Token di autenticazione',
      fr: 'Jeton d\'authentification',
      es: 'Token de autenticación',
      hr: 'Token za provjeru autentičnosti',
      cz: 'Autentizační token',
    ),
  ),
  _guestUserEncodedData(
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
  _bookmarks(
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
  _shopSearchHistory(
    GsaServiceI18NModelTranslatedValue(
      'Shop Search History',
      enIe: 'Shop Search History',
      enGb: 'Shop Search History',
      de: 'Shop-Suchverlauf',
      it: 'Storia della ricerca del negozio',
      fr: 'Historique de recherche de magasins',
      es: 'Historial de búsqueda de tiendas',
      hr: 'Povijest pretraživanja trgovine',
      cz: 'Historie vyhledávání obchodů',
    ),
  ),
  _themeBrightness(
    GsaServiceI18NModelTranslatedValue(
      'Theme Brightness',
      enIe: 'Theme Brightness',
      enGb: 'Theme Brightness',
      de: 'Thema Helligkeit',
      it: 'Luminosità del tema',
      fr: 'Luminosité du thème',
      es: 'Brillo del tema',
      hr: 'Svjetlina teme',
      cz: 'Jas motivu',
    ),
  );

  const GsaServiceCacheI18N(
    this.value,
  );

  @override
  final GsaServiceI18NModelTranslatedValue value;
}
