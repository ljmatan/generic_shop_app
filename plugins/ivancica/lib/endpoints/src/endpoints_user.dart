import 'package:generic_shop_app_architecture/gsar.dart';

/// User management (login, register...) API endpoints.
///
enum GivEndpointsUser with GsarApiEndpoints {
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
  GsarApiEndpointMethodType get method {
    switch (this) {
      case GivEndpointsUser.login:
        return GsarApiEndpointMethodType.httpPost;
    }
  }
}
