import 'package:generic_shop_app_architecture/gsar.dart';

/// User management (login, register...) API endpoints.
///
enum GivEndpointsUser with GsaApiEndpoints {
  /// Sends a request to the server to authenticate the user.
  ///
  login;

  @override
  String get path {
    switch (this) {
      case GivEndpointsUser.login:
        return 'shop/user/login';
    }
  }

  @override
  GsaApiEndpointMethodType get method {
    switch (this) {
      case GivEndpointsUser.login:
        return GsaApiEndpointMethodType.httpPost;
    }
  }
}
