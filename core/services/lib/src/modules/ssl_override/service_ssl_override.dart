import 'dart:io' as dart_io;

import 'package:generic_shop_app_architecture/gsar.dart';

/// This class facilitates overriding [HttpClient] in order to accept invalid SSL certificates.
///
class _SslOverride extends dart_io.HttpOverrides {
  /// Generates an instance of the class with specified [acceptedHosts] collection.
  ///
  _SslOverride(
    this.acceptedHosts,
  );

  /// Collection of host addresses accepted for processing network requests with invalid certificates.
  ///
  final List<String>? acceptedHosts;

  @override
  dart_io.HttpClient createHttpClient(
    dart_io.SecurityContext? context,
  ) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        dart_io.X509Certificate cert,
        String host,
        int port,
      ) {
        return acceptedHosts?.contains(host) == true;
      };
  }
}

/// Service implemented for overriding invalid SSL certificate callbacks.
///
/// In practice, this class would allow for accepting a secure connection with a server
/// certificate that cannot be authenticated by any of the available trusted root certificates.
///
class GsaServiceSslOverride extends GsaService {
  GsaServiceSslOverride._();

  static final _instance = GsaServiceSslOverride._();

  /// Globally-accessible singleton class instance.
  ///
  static GsaServiceSslOverride get instance => _instance() as GsaServiceSslOverride;

  /// Collection of host addresses accepted for processing network requests with invalid certificates.
  ///
  List<String>? _acceptedHosts;

  /// Forwards a collection of host addresses marked as accepted with any certificate status.
  ///
  /// To clear the list of accepted hosts, simply forward `null` with the [hosts] parameter.
  ///
  void setAcceptedHosts(List<String>? hosts) {
    _acceptedHosts = hosts;
    dart_io.HttpOverrides.global = _SslOverride(
      _acceptedHosts,
    );
  }
}
