part of '../endpoints.dart';

enum GsaEndpointsUsers with GsaApiEndpoints {
  /// Registers a given user record to the database.
  ///
  register,

  /// Authenticate with the server using the username and password.
  ///
  login,

  /// Authenticate with the server using only a given password.
  ///
  loginPassword,

  /// Retrieves the details for the specified user account.
  ///
  getUserDetails,

  /// Edit the user data with the data provided through the endpoint.
  ///
  editUserDetails,

  /// Request for the accoutn deletion confirmation to be sent to the specified email.
  ///
  requestDeletion,

  /// Deletes all of the associated user records from the database.
  ///
  deleteAll,

  /// Marks the user as deleted and removes any personal user data from the database.
  ///
  deleteSoft;

  @override
  String get path {
    switch (this) {
      case GsaEndpointsUsers.login:
        return 'login';
      case GsaEndpointsUsers.loginPassword:
        return 'login-password';
      case GsaEndpointsUsers.register:
        return 'register';
      case GsaEndpointsUsers.getUserDetails:
        return 'details';
      case GsaEndpointsUsers.editUserDetails:
        return 'details';
      case GsaEndpointsUsers.requestDeletion:
        return 'ask-delete';
      case GsaEndpointsUsers.deleteAll:
        return 'delete';
      case GsaEndpointsUsers.deleteSoft:
        return 'soft-delete';
    }
  }

  @override
  GsaApiEndpointMethodType get method {
    switch (this) {
      case GsaEndpointsUsers.login:
        return GsaApiEndpointMethodType.httpPost;
      case GsaEndpointsUsers.loginPassword:
        return GsaApiEndpointMethodType.httpPost;
      case GsaEndpointsUsers.register:
        return GsaApiEndpointMethodType.httpPost;
      case GsaEndpointsUsers.getUserDetails:
        return GsaApiEndpointMethodType.httpGet;
      case GsaEndpointsUsers.editUserDetails:
        return GsaApiEndpointMethodType.httpPatch;
      case GsaEndpointsUsers.requestDeletion:
        return GsaApiEndpointMethodType.httpDelete;
      case GsaEndpointsUsers.deleteAll:
        return GsaApiEndpointMethodType.httpDelete;
      case GsaEndpointsUsers.deleteSoft:
        return GsaApiEndpointMethodType.httpDelete;
    }
  }
}
