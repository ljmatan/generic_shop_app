part of '../database.dart';

/// Predefined `users` database collections.
///
enum _GsamDatabaseUsersCollections {
  /// User-type data collection.
  ///
  users,

  /// Stored registered user passwords.
  ///
  passwords,

  /// Stored access token with relation to specific access levels.
  ///
  accessTokens,
}

class GsamDatabaseUsers extends GsamDatabase {
  GsamDatabaseUsers._() : super._();

  static final _instance = GsamDatabaseUsers._();

  factory GsamDatabaseUsers.instance(shelf.Request request) {
    return _instance(request) as GsamDatabaseUsers;
  }

  @override
  String get _name => 'users';

  /// Records a new [user] entry to the database.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  /// Returns the newly-created user ID.
  ///
  Future<String> register({
    required GsaaModelUser user,
    required String password,
  }) async {
    if (user.username == null) {
      throw 'Username must be provided for registration.';
    }
    final existingUser = await _instance._findOne(
      collectionId: _GsamDatabaseUsersCollections.users.name,
      selectors: [
        ('username', user.username!),
      ],
    );
    if (existingUser != null) {
      throw 'User with name ${user.username}} already exists.';
    }
    final userId = await _instance._insertOne(
      collectionId: _GsamDatabaseUsersCollections.users.name,
      body: user.toJson(),
    );
    final encryptedPassword = password;
    await _instance._insertOne(
      collectionId: _GsamDatabaseUsersCollections.passwords.name,
      body: {
        'userId': userId,
        'value': encryptedPassword,
      },
    );
    return userId;
  }

  /// Retrieves a first database record with a matching [userId] identifier value.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  Future<GsaaModelUser?> findById({
    required String userId,
  }) async {
    final result = await _instance._findOne(
      collectionId: _GsamDatabaseUsersCollections.users.name,
      selectors: [('id', userId)],
    );
    if (result == null) return null;
    try {
      final serializedResult = GsaaModelUser.fromJson(result);
      return serializedResult;
    } catch (e) {
      // TODO: Log etc.
      return null;
    }
  }

  /// Retrieves a first database record with a matching [username] identifier value.
  ///
  /// Optional [collectionId] property can be provided to further specify the user collection,
  /// otherwise it defaults to the [GsamConfig.client] name.
  ///
  Future<GsaaModelUser?> findByUsername({
    required String username,
  }) async {
    final result = await _instance._findOne(
      collectionId: _GsamDatabaseUsersCollections.users.name,
      selectors: [('username', username)],
    );
    if (result == null) return null;
    try {
      final serializedResult = GsaaModelUser.fromJson(result);
      return serializedResult;
    } catch (e) {
      // TODO: Log etc.
      return null;
    }
  }

  /// Checks the given [username] and [password] against the given database records
  /// and returns a new session ID if the login is successful.
  ///
  Future<({String userId, String token})> login({
    required String username,
    required String password,
  }) async {
    final user = await findByUsername(username: username);
    if (user == null) {
      throw 'User $username not found.';
    }
    if (user.id == null) {
      throw 'User missing an ID.';
    }
    final userPassword = await _instance._findOne(
      collectionId: _GsamDatabaseUsersCollections.passwords.name,
      selectors: [('userId', user.id!)],
    );
    // TODO: Encrypt decrypt etc.
    if (userPassword?['value'] == password) {
      return (
        token: _randomId,
        userId: user.id!,
      );
    } else {
      throw 'Incorrect password.';
    }
  }

  /// Checks the given [password] against the database records,
  /// and returns a new session ID alongside the user ID if the login is successful.
  ///
  Future<({String userId, String token})> loginPassword({
    required String password,
  }) async {
    final matchingPassword = await _instance._findOne(
      collectionId: _GsamDatabaseUsersCollections.accessTokens.name,
      selectors: [
        ('value', password),
      ],
    );
    // TODO: Encrypt etc.
    if (matchingPassword == null) {
      throw 'No access code match for $password.';
    } else {
      return (userId: '', token: '');
    }
  }

  /// Removes all of the user database records.
  ///
  Future<void> delete({
    required String userId,
  }) async {
    await _instance._deleteOne(
      collectionId: _GsamDatabaseUsersCollections.users.name,
      selectors: [('id', userId)],
    );
  }

  /// Removes any personal user-associated data from the database by rewriting them.
  ///
  Future<void> softDelete({
    required String userId,
  }) async {
    await _instance._updateOne(
      collectionId: _GsamDatabaseUsersCollections.users.name,
      selectors: [('id', userId)],
      body: {
        'username': 'DELETED',
        'personalDetails': null,
        'contact': null,
        'address': null,
      },
    );
  }

  /// Updates the stored user data with the specified values.
  ///
  Future<void> updateUserDetails({
    required String userId,
    required Map<String, dynamic> body,
  }) async {
    await _instance._updateOne(
      collectionId: _GsamDatabaseUsersCollections.users.name,
      selectors: [('id', userId)],
      body: body,
    );
  }

  /// Updates the user password with the given value.
  ///
  Future<void> updatePassword({
    required String userId,
    required String password,
  }) async {
    // TODO: Encrypt
    final encryptedPassword = password;
    await _instance._updateOne(
      collectionId: _GsamDatabaseUsersCollections.passwords.name,
      selectors: [('userId', userId)],
      body: {
        'value': encryptedPassword,
      },
    );
  }
}
