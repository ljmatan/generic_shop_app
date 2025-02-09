part of '../../../api.dart';

extension GsaEndpointsUsersExt on GsaEndpointsUsers {
  Future<shelf.Response> Function(shelf.Request) get handler {
    switch (this) {
      case GsaEndpointsUsers.register:
        return GsamApiUsers0.instance.register;
      case GsaEndpointsUsers.login:
        return GsamApiUsers0.instance.login;
      case GsaEndpointsUsers.loginPassword:
        return GsamApiUsers0.instance.loginPassword;
      case GsaEndpointsUsers.getUserDetails:
        return GsamApiUsers0.instance.getUserDetails;
      case GsaEndpointsUsers.editUserDetails:
        return GsamApiUsers0.instance.editUserDetails;
      case GsaEndpointsUsers.requestDeletion:
        return GsamApiUsers0.instance.requestDeletion;
      case GsaEndpointsUsers.deleteAll:
        return GsamApiUsers0.instance.delete;
      case GsaEndpointsUsers.deleteSoft:
        return GsamApiUsers0.instance.softDelete;
    }
  }
}
