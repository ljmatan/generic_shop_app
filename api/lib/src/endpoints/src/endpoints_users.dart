part of '../endpoints.dart';

enum GsaaEndpointsUsers {
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
  deleteSoft,
}

extension GsaaEndpointsUsersPathExt on GsaaEndpointsUsers {
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

  String get method {
    return _method.id;
  }

  _EndpointMethodType get _method {
    switch (this) {
      case GsaaEndpointsUsers.login:
        return _EndpointMethodType.postRequest;
      case GsaaEndpointsUsers.loginPassword:
        return _EndpointMethodType.postRequest;
      case GsaaEndpointsUsers.register:
        return _EndpointMethodType.postRequest;
      case GsaaEndpointsUsers.getUserDetails:
        return _EndpointMethodType.getRequest;
      case GsaaEndpointsUsers.editUserDetails:
        return _EndpointMethodType.patchRequest;
      case GsaaEndpointsUsers.requestDeletion:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsUsers.deleteAll:
        return _EndpointMethodType.deleteRequest;
      case GsaaEndpointsUsers.deleteSoft:
        return _EndpointMethodType.deleteRequest;
    }
  }
}
