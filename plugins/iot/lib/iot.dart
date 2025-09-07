/// Generic Shop App Internet-of-Things Plugin.
///
class Giot {
  const Giot._();

  /// Globally-accessible object instance.
  ///
  static const instance = Giot._();

  /// Access token used to authenticate against the
  /// [Firebase services](https://firebase.google.com/docs/database/rest/auth).
  ///
  String get firebaseAccessToken {
    final token = const String.fromEnvironment('GIOT_FIREBASE_ACCESS_TOKEN');
    if (token.isEmpty) {
      throw 'GIOT_FIREBASE_ACCESS_TOKEN dart-define variable must be provided.';
    }
    return token;
  }
}
