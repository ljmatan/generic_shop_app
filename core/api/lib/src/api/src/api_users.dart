import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// API endpoint call and handling implementation references.
///
extension GsaEndpointsUsersImplExt on GsaEndpointsUsers {
  Function get implementation {
    switch (this) {
      case GsaEndpointsUsers.login:
        return GsaApiUsers.instance.login;
      case GsaEndpointsUsers.loginPassword:
        return GsaApiUsers.instance.loginPassword;
      case GsaEndpointsUsers.register:
        return GsaApiUsers.instance.register;
      case GsaEndpointsUsers.getUserDetails:
        return GsaApiUsers.instance.getUserDetails;
      case GsaEndpointsUsers.editUserDetails:
        return GsaApiUsers.instance.editUserDetails;
      case GsaEndpointsUsers.requestDeletion:
        return GsaApiUsers.instance.requestDeletion;
      case GsaEndpointsUsers.deleteAll:
        return GsaApiUsers.instance.deleteAll;
      case GsaEndpointsUsers.deleteSoft:
        return GsaApiUsers.instance.deleteSoft;
    }
  }
}

class GsaApiUsers extends GsaApi {
  const GsaApiUsers._();

  static const instance = GsaApiUsers._();

  @override
  String get protocol => 'http';

  /// Register a user instance to the system.
  ///
  Future<String> register({
    required String username,
    required String password,
    String? email,
    String? phoneCountryCode,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? gender,
    DateTime? dateOfBirth,
  }) async {
    final response = await post(
      GsaEndpointsUsers.register.path,
      GsaModelUser(
        username: username,
        personalDetails: GsaModelPerson(
          firstName: firstName,
          lastName: lastName,
          gender: gender,
          dateOfBirthIso8601: dateOfBirth?.toIso8601String(),
        ),
        contact: GsaModelContact(email: email, phoneCountryCode: phoneCountryCode, phoneNumber: phoneNumber),
        address: GsaModelAddress(),
      ).toJson()
        ..['password'] = password,
    );
    final userId = response['userId'];
    if (userId == null) {
      throw 'User ID missing from registration response.';
    } else {
      return userId;
    }
  }

  /// Login a user with the given [username] and [password].
  ///
  Future<String> login({required String username, required String password}) async {
    final response = await post(GsaEndpointsUsers.login.path, {'username': username, 'password': password});
    final securityToken = response['securityToken'];
    if (securityToken is! String) {
      throw 'Security token is missing.';
    }
    return securityToken;
  }

  /// Login a user with the given [password].
  ///
  Future<String> loginPassword({required String username, required String password}) async {
    final response = await post(GsaEndpointsUsers.loginPassword.path, {'password': password});
    final securityToken = response['securityToken'];
    if (securityToken is! String) {
      throw 'Security token is missing.';
    }
    return securityToken;
  }

  /// Retrieve the details for a given user.
  ///
  Future<GsaModelUser> getUserDetails([String? userId]) async {
    final response = await get(GsaEndpointsUsers.getUserDetails.path + (userId != null ? '?userId=$userId' : ''));
    try {
      final user = GsaModelUser.fromJson(response);
      return user;
    } catch (e) {
      throw 'Couldn\'t serialize user details:\n$response';
    }
  }

  /// Edit user details with the provided information.
  ///
  Future<void> editUserDetails({String? username}) async {
    await patch(GsaEndpointsUsers.editUserDetails.path, {if (username != null) 'username': username});
  }

  /// Request for an account deletion confirmation to be sent to the specified [email] address.
  ///
  Future<void> requestDeletion({required String email, required String password}) async {
    await delete(GsaEndpointsUsers.requestDeletion.path, body: {'email': email, 'password': password});
  }

  /// Deletes the user data from the database.
  ///
  Future<void> deleteAll({required String password}) async {
    await delete(GsaEndpointsUsers.deleteAll.path, body: {'password': password});
  }

  /// Marks the user as deleted, without deleting the actual data from the database.
  ///
  Future<void> deleteSoft({required String password}) async {
    await delete(GsaEndpointsUsers.deleteSoft.path, body: {'password': password});
  }
}
