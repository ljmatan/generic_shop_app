import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// API endpoint call and handling implementation references.
///
extension GsaaEndpointsUsersImplExt on GsaaEndpointsUsers {
  Function get implementation {
    switch (this) {
      case GsaaEndpointsUsers.login:
        return GsaaApiUsers.instance.login;
      case GsaaEndpointsUsers.loginPassword:
        return GsaaApiUsers.instance.loginPassword;
      case GsaaEndpointsUsers.register:
        return GsaaApiUsers.instance.register;
      case GsaaEndpointsUsers.getUserDetails:
        return GsaaApiUsers.instance.getUserDetails;
      case GsaaEndpointsUsers.editUserDetails:
        return GsaaApiUsers.instance.editUserDetails;
      case GsaaEndpointsUsers.requestDeletion:
        return GsaaApiUsers.instance.requestDeletion;
      case GsaaEndpointsUsers.deleteAll:
        return GsaaApiUsers.instance.deleteAll;
      case GsaaEndpointsUsers.deleteSoft:
        return GsaaApiUsers.instance.deleteSoft;
    }
  }
}

class GsaaApiUsers extends GsarApi {
  const GsaaApiUsers._();

  static const instance = GsaaApiUsers._();

  @override
  String get protocol => 'http';

  @override
  String get identifier => 'users';

  @override
  int get version => 0;

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
      GsaaEndpointsUsers.register.path,
      GsaaModelUser(
        username: username,
        personalDetails: GsaaModelPerson(
          firstName: firstName,
          lastName: lastName,
          gender: gender,
          dateOfBirthIso8601: dateOfBirth?.toIso8601String(),
        ),
        contact: GsaaModelContact(
          email: email,
          phoneCountryCode: phoneCountryCode,
          phoneNumber: phoneNumber,
        ),
        address: null,
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
  Future<String> login({
    required String username,
    required String password,
  }) async {
    final response = await post(
      GsaaEndpointsUsers.login.path,
      {
        'username': username,
        'password': password,
      },
    );
    final securityToken = response['securityToken'];
    if (securityToken is! String) {
      throw 'Security token is missing.';
    }
    return securityToken;
  }

  /// Login a user with the given [password].
  ///
  Future<String> loginPassword({
    required String username,
    required String password,
  }) async {
    final response = await post(
      GsaaEndpointsUsers.loginPassword.path,
      {
        'password': password,
      },
    );
    final securityToken = response['securityToken'];
    if (securityToken is! String) {
      throw 'Security token is missing.';
    }
    return securityToken;
  }

  /// Retrieve the details for a given user.
  ///
  Future<GsaaModelUser> getUserDetails([String? userId]) async {
    final response = await get(
      GsaaEndpointsUsers.getUserDetails.path + (userId != null ? '?userId=$userId' : ''),
    );
    try {
      final user = GsaaModelUser.fromJson(response);
      return user;
    } catch (e) {
      throw 'Couldn\'t serialize user details:\n$response';
    }
  }

  /// Edit user details with the provided information.
  ///
  Future<void> editUserDetails({
    String? username,
  }) async {
    await patch(
      GsaaEndpointsUsers.editUserDetails.path,
      {
        if (username != null) 'username': username,
      },
    );
  }

  /// Request for an account deletion confirmation to be sent to the specified [email] address.
  ///
  Future<void> requestDeletion({
    required String email,
    required String password,
  }) async {
    await delete(
      GsaaEndpointsUsers.requestDeletion.path,
      body: {
        'email': email,
        'password': password,
      },
    );
  }

  /// Deletes the user data from the database.
  ///
  Future<void> deleteAll({
    required String password,
  }) async {
    await delete(
      GsaaEndpointsUsers.deleteAll.path,
      body: {
        'password': password,
      },
    );
  }

  /// Marks the user as deleted, without deleting the actual data from the database.
  ///
  Future<void> deleteSoft({
    required String password,
  }) async {
    await delete(
      GsaaEndpointsUsers.deleteSoft.path,
      body: {
        'password': password,
      },
    );
  }
}
