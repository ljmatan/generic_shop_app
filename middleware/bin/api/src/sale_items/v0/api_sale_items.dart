part of '../../../api.dart';

class GsamApiSaleItems0 extends GsamApi {
  GsamApiSaleItems0._() : super._();

  static final instance = GsamApiSaleItems0._();

  @override
  int get version => 0;

  @override
  String get identifier => 'sale-items';

  @override
  List<
      ({
        String path,
        String method,
        Future<shelf.Response> Function(shelf.Request) handler,
      })> get endpoints {
    return [
      for (final endpoint in GsaaEndpointsSaleItems.values)
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
        await GsamDatabaseUsers.instance(request).register(
          user: user,
          password: password,
        );
        return _responseOk();
      },
      requestBodyTypeChecks: [
        ('username', String),
        ('password', String),
      ],
    );
  }

  Future<shelf.Response> getItemDetails(shelf.Request request) async {
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
    );
  }

  Future<shelf.Response> editItemDetails(shelf.Request request) async {
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
      requestBodyTypeChecks: [
        ('token', String),
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
      requestBodyTypeChecks: [
        ('token', String),
      ],
    );
  }

  Future<shelf.Response> getAllItems(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final items = await GsamDatabaseSaleItems.instance(request).getAllItems();
        return _responseOk(
          body: {
            'items': items?.map((item) => item.toJson()) ?? [],
          },
        );
      },
    );
  }

  Future<shelf.Response> getItemCategories(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final categories = await GsamDatabaseSaleItems.instance(request).getItemCategories();
        return _responseOk(
          body: {
            'categories': categories?.map((item) => item.toJson()) ?? [],
          },
        );
      },
    );
  }

  Future<shelf.Response> getFeaturedItems(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final items = await GsamDatabaseSaleItems.instance(request).getFeaturedItems();
        return _responseOk(
          body: {
            'items': items?.map((item) => item.toJson()) ?? [],
          },
        );
      },
    );
  }

  Future<shelf.Response> searchItems(shelf.Request request) async {
    return await _parseRequest(
      request,
      (requestHeaders, requestBody, userId) async {
        final items = await GsamDatabaseSaleItems.instance(request).searchItems();
        return _responseOk(
          body: {
            'items': items?.map((item) => item.toJson()) ?? [],
          },
        );
      },
    );
  }
}
