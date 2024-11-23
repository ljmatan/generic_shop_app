part of '../../../api.dart';

extension GsaaEndpointsUsersExt on GsaaEndpointsUsers {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaaEndpointsUsers.register:
        return GsamApiUsers0.instance.register;
      case GsaaEndpointsUsers.login:
        return GsamApiUsers0.instance.login;
      case GsaaEndpointsUsers.loginPassword:
        return GsamApiUsers0.instance.loginPassword;
      case GsaaEndpointsUsers.getUserDetails:
        return GsamApiUsers0.instance.getUserDetails;
      case GsaaEndpointsUsers.editUserDetails:
        return GsamApiUsers0.instance.editUserDetails;
      case GsaaEndpointsUsers.requestDeletion:
        return GsamApiUsers0.instance.requestDeletion;
      case GsaaEndpointsUsers.deleteAll:
        return GsamApiUsers0.instance.delete;
      case GsaaEndpointsUsers.deleteSoft:
        return GsamApiUsers0.instance.softDelete;
    }
  }
}
