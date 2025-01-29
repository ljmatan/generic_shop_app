part of '../endpoints.dart';

enum GsaaEndpointsUsers implements GsarApiEndpoints {
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
      case GsaaEndpointsUsers.login:
        return 'login';
      case GsaaEndpointsUsers.loginPassword:
        return 'login-password';
      case GsaaEndpointsUsers.register:
        return 'register';
      case GsaaEndpointsUsers.getUserDetails:
        return 'details';
      case GsaaEndpointsUsers.editUserDetails:
        return 'details';
      case GsaaEndpointsUsers.requestDeletion:
        return 'ask-delete';
      case GsaaEndpointsUsers.deleteAll:
        return 'delete';
      case GsaaEndpointsUsers.deleteSoft:
        return 'soft-delete';
    }
  }

  @override
  GsarApiEndpointMethodType get method {
    switch (this) {
      case GsaaEndpointsUsers.login:
        return GsarApiEndpointMethodType.httpPost;
      case GsaaEndpointsUsers.loginPassword:
        return GsarApiEndpointMethodType.httpPost;
      case GsaaEndpointsUsers.register:
        return GsarApiEndpointMethodType.httpPost;
      case GsaaEndpointsUsers.getUserDetails:
        return GsarApiEndpointMethodType.httpGet;
      case GsaaEndpointsUsers.editUserDetails:
        return GsarApiEndpointMethodType.httpPatch;
      case GsaaEndpointsUsers.requestDeletion:
        return GsarApiEndpointMethodType.httpDelete;
      case GsaaEndpointsUsers.deleteAll:
        return GsarApiEndpointMethodType.httpDelete;
      case GsaaEndpointsUsers.deleteSoft:
        return GsarApiEndpointMethodType.httpDelete;
    }
  }

  @override
  GsarModel? get requestFields {
    return null;
  }

  @override
  GsarModel? get responseFields {
    return null;
  }
}
