part of '../../api.dart';

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
      case GsaaEndpointsUsers.delete:
        return GsamApiUsers0.instance.delete;
      case GsaaEndpointsUsers.softDelete:
        return GsamApiUsers0.instance.softDelete;
    }
  }
}

class GsamApiUsers0 extends GsamApi {
  GsamApiUsers0._() : super._();

  static final instance = GsamApiUsers0._();

  @override
  int get version => 0;

  @override
  String get identifier => 'user';

  @override
  List<
      ({
        String path,
        String method,
        Future<shelf.Response> Function(shelf.Request) handler,
      })> get endpoints {
    return [
      for (final endpoint in GsaaEndpointsUsers.values)
        (
          path: endpoint.path,
          method: endpoint.method,
          handler: endpoint.handler,
        ),
    ];
  }

  Future<shelf.Response> register(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = GsaaModelUser.fromJson(requestBody!);
        final existingUser = await GsamDatabaseUsers.instance(request).findByUsername(
          username: user.username!,
        );
        if (existingUser != null) {
          return _responseError(message: 'Username already registered.');
        }
        final password = requestBody['password'] as String;
        final userId = await GsamDatabaseUsers.instance(request).register(
          user: user,
          password: password,
        );
        return _responseOk(
          body: {
            'userId': userId,
          },
        );
      },
      requestBodyTypeChecks: [
        ('username', String),
        ('password', String),
      ],
    );
  }

  Future<shelf.Response> login(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final username = requestBody!['username'] as String;
        final password = requestBody['password'] as String;
        try {
          final sessionData = await GsamDatabaseUsers.instance(request).login(
            username: username,
            password: password,
          );
          _createSession(token: sessionData.toString(), userId: sessionData.userId);
          return _responseOk(
            body: {
              'securityToken': sessionData.token,
            },
          );
        } catch (e) {
          // TODO: Log
          return _responseError(
            message: 'Login failed.',
          );
        }
      },
      requestBodyTypeChecks: [
        ('username', String),
        ('password', String),
      ],
    );
  }

  Future<shelf.Response> loginPassword(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final password = requestBody!['password'] as String;
        try {
          final sessionData = await GsamDatabaseUsers.instance(request).loginPassword(
            password: password,
          );
          _createSession(token: sessionData.toString(), userId: sessionData.userId);
          return _responseOk(
            body: {
              'securityToken': sessionData.token,
            },
          );
        } catch (e) {
          // TODO: Log
          return _responseError(
            message: 'Login failed.',
          );
        }
      },
      requestBodyTypeChecks: [
        ('password', String),
      ],
    );
  }

  Future<shelf.Response> getUserDetails(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          return _responseOk(
            body: user.toJson(),
          );
        }
      },
      requiresUserId: true,
    );
  }

  Future<shelf.Response> editUserDetails(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          await GsamDatabaseUsers.instance(request).updateUserDetails(
            userId: user.id!,
            body: requestBody!,
          );
          return _responseOk();
        }
      },
      requiresUserId: true,
      requestBodyTypeChecks: [
        ('token', String),
      ],
    );
  }

  Future<shelf.Response> requestDeletion(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          // TODO: Send deletion confirmation email
          return _responseOk();
        }
      },
      requiresUserId: true,
      requestBodyTypeChecks: [
        ('password', String),
      ],
    );
  }

  Future<shelf.Response> delete(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          await GsamDatabaseUsers.instance(request).delete(userId: user.id!);
          return _responseOk();
        }
      },
      requiresUserId: true,
      requestBodyTypeChecks: [
        ('token', String),
      ],
    );
  }

  Future<shelf.Response> softDelete(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final user = await GsamDatabaseUsers.instance(request).findById(userId: userId!);
        if (user == null) {
          return _responseError(message: 'No user found for ID $userId.');
        } else {
          await GsamDatabaseUsers.instance(request).softDelete(userId: user.id!);
          return _responseOk();
        }
      },
      requiresUserId: true,
      requestBodyTypeChecks: [
        ('token', String),
      ],
    );
  }
}
