// ignore_for_file: public_member_api_docs

part of '../route_login.dart';

enum GsaRouteLoginI18N implements GsaServiceI18NBaseTranslations {
  appBarTitle(
    GsaServiceI18NModelTranslatedValue(
      'Login',
      enIe: 'Login',
      enGb: 'Login',
      de: 'Login',
      it: 'Login',
      fr: 'Se connecter',
      es: 'Acceso',
      hr: 'Prijava',
      cz: 'Přihlášení',
    ),
  ),
  accountDetailsTitle(
    GsaServiceI18NModelTranslatedValue(
      'Account Details',
      enIe: 'Account Details',
      enGb: 'Account Details',
      de: 'Kontodetails',
      it: 'Dettagli dell\'account',
      fr: 'Détails du compte',
      es: 'Detalles de la cuenta',
      hr: 'Podatci za prijavu',
      cz: 'Podrobnosti o účtu',
    ),
  ),
  emailInputFieldTitle(
    GsaServiceI18NModelTranslatedValue(
      'Email',
      enIe: 'Email',
      enGb: 'Email',
      de: 'E-mail',
      it: 'E-mail',
      fr: 'E-mail',
      es: 'Correo electrónico',
      hr: 'Email',
      cz: 'E-mail',
    ),
  ),
  passwordInputFieldTitle(
    GsaServiceI18NModelTranslatedValue(
      'Password',
      enIe: 'Password',
      enGb: 'Password',
      de: 'Passwort',
      it: 'password',
      fr: 'Mot de passe',
      es: 'Contraseña',
      hr: 'Lozinka',
      cz: 'Heslo',
    ),
  ),
  openForgotPasswordScreenButtonTitle(
    GsaServiceI18NModelTranslatedValue(
      'Forgot password?',
      enIe: 'Forgot password?',
      enGb: 'Forgot password?',
      de: 'Passwort vergessen?',
      it: 'Ha dimenticato la password?',
      fr: 'Mot de passe oublié?',
      es: '¿Has olvidado tu contraseña?',
      hr: 'Zaboravljena lozinka?',
      cz: 'Zapomenuté heslo?',
    ),
  ),
  openRegisterScreenButtonTitle(
    GsaServiceI18NModelTranslatedValue(
      'Register',
      enIe: 'Register',
      enGb: 'Register',
      de: 'Registrieren',
      it: 'Registro',
      fr: 'Registre',
      es: 'Registro',
      hr: 'Registracija',
      cz: 'Rejstřík',
    ),
  ),
  authenticationOptionSeparator(
    GsaServiceI18NModelTranslatedValue(
      'or',
      enIe: 'or',
      enGb: 'or',
      de: 'oder',
      it: 'O',
      fr: 'ou',
      es: 'o',
      hr: 'ili',
      cz: 'nebo',
    ),
  ),
  loginButtonTitle(
    GsaServiceI18NModelTranslatedValue(
      'Login',
      enIe: 'Login',
      enGb: 'Login',
      de: 'login',
      it: 'Login',
      fr: 'Se connecter',
      es: 'Acceso',
      hr: 'Prijava',
      cz: 'Přihlášení',
    ),
  ),
  continueAsGuestButtonTitle(
    GsaServiceI18NModelTranslatedValue(
      'Continue as Guest',
      enIe: 'Continue as Guest',
      enGb: 'Continue as Guest',
      de: 'Weiter als Gast',
      it: 'Continua come ospite',
      fr: 'Continuez en tant qu\'invité',
      es: 'Continuar como invitada',
      hr: 'Nastavi bez prijave',
      cz: 'Pokračujte jako host',
    ),
  );

  const GsaRouteLoginI18N(this.value);

  @override
  final GsaServiceI18NModelTranslatedValue value;
}
