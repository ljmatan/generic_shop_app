library database;

import 'dart:async';
import 'dart:math';

import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:generic_shop_app_api/api.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../server.dart';

part 'src/db_merchants.dart';
part 'src/db_orders.dart';
part 'src/db_sale_items.dart';
part 'src/db_users.dart';

/// Base class for a database connection implementation.
///
abstract class GsamDatabase {
  GsamDatabase._() {
    _observables.add(this);
  }

  /// List of active subclass instances.
  ///
  static final _observables = <GsamDatabase>[];

  /// Database host address.
  ///
  String get _host {
    return 'localhost';
  }

  /// Port to which the database service is subscribed.
  ///
  int get _port {
    return 27017;
  }

  /// Database name prefix.
  ///
  String get _prefix {
    return GsamConfig.client.name;
  }

  /// Unique database identifier.
  ///
  String get _name;

  /// The database instance client.
  ///
  late final mongo.Db _client;

  /// https://github.com/mongo-dart/mongo_dart/issues/198
  ///
  Future<mongo.Db> client() async {
    if (!_client.isConnected) {
      try {
        await _client.close();
      } catch (e) {
        await _client.open();
      }
    }
    return _client;
  }

  /// Allocate the database resources.
  ///
  Future<void> _init() async {
    _client = mongo.Db('mongodb://$_host:$_port/${_prefix}_$_name');
    await _client.open();
  }

  /// Allocate all of the subclass instance resources.
  ///
  static Future<void> init() async {
    await Future.wait(
      [
        for (final observable in _observables) observable._init(),
      ],
    );
  }

  /// Deallocate the database resources.
  ///
  Future<void> dispose() async {
    await _client.close();
  }

  /// Enables invoking the object as a callable method, logs the request.
  ///
  GsamDatabase call(shelf.Request request) {
    // TODO: Log
    return this;
  }

  /// Retrieves a database collection with a specific [id].
  ///
  Future<mongo.DbCollection> _getCollection(String id) async {
    return mongo.DbCollection(await client(), id);
  }

  /// Generates a random 12-character length string based on the current time.
  ///
  String get _randomId {
    const length = 12;
    const chars = '0123456789abcdefghijklmnopqrstuvwxyz';
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    // Convert timestamp to a base-36 string (digits and lowercase letters)
    String randomString = '';
    while (timestamp > 0) {
      final remainder = timestamp % chars.length;
      randomString = chars[remainder] + randomString;
      timestamp ~/= chars.length; // Efficient integer division
    }
    // Truncate or pad with random characters
    randomString = randomString.substring(0, length);
    if (randomString.length < length) {
      final random = Random();
      randomString += String.fromCharCodes(
        List.generate(
          length - randomString.length,
          (_) => random.nextInt(chars.length),
        ),
      );
    }

    return randomString;
  }

  Future<Map<String, dynamic>?> _findOne({
    required String collectionId,
    required List<(String, String)> selectors,
  }) async {
    final collection = await _getCollection(collectionId);
    final query = mongo.where;
    for (final selector in selectors) {
      query.eq(selector.$1, selector.$2);
    }
    final result = await collection.findOne(query);
    return result;
  }

  Future<List<Map<String, dynamic>>?> _findMany({
    required String collectionId,
    List<(String, dynamic)>? selectors,
    int maxResults = 20,
  }) async {
    final collection = await _getCollection(collectionId);
    mongo.SelectorBuilder? query = mongo.where.limit(maxResults);
    if (selectors != null) {
      for (final selector in selectors) {
        query.eq(selector.$1, selector.$2);
      }
    }
    final result = await collection.find(query).toList();
    return result.isEmpty ? null : result;
  }

  Future<String> _insertOne({
    required String collectionId,
    required Map<String, dynamic> body,
  }) async {
    final collection = await _getCollection(collectionId);
    if (body['id'] != String || body['id'].isEmpty) body['id'] = _randomId;
    final result = await collection.insertOne(body);
    if (result.hasWriteErrors) {
      // TODO: Log?
      throw 'Error inserting one record into $_name: $collectionId\n$body';
    }
    return body['id'] as String;
  }

  Future<void> _updateOne({
    required String collectionId,
    required List<(String, String)> selectors,
    required Map<String, dynamic> body,
  }) async {
    final collection = await _getCollection(collectionId);
    final result = await collection.updateOne(
      {for (final selector in selectors) selector.$1: selector.$2},
      {
        '\$set': {
          for (final bodyEntry in body.entries)
            if (bodyEntry.value == null || <Type>{String, int, double, List}.contains(bodyEntry.value.runtimeType))
              bodyEntry.key: bodyEntry.value
            else if (bodyEntry.value is Iterable)
              bodyEntry.key: bodyEntry.value.toList()
            else if (bodyEntry.value is Map)
              for (final bodyChildEntry in bodyEntry.value.entries) '${bodyEntry.key}.${bodyChildEntry.key}': bodyChildEntry.value,
        },
      },
    );
    if (result.hasWriteErrors) {
      // TODO: Log?
      throw 'Error updating one record from $_name: $collectionId\n$body';
    }
  }

  Future<void> _deleteOne({
    required String collectionId,
    required List<(String, String)> selectors,
  }) async {
    final collection = await _getCollection(collectionId);
    final result = await collection.deleteOne({for (final selector in selectors) selector.$1: selector.$2});
    if (result.hasWriteErrors) {
      // TODO: Log?
      throw 'Error deleting one record from $_name: $collectionId';
    }
  }

  Future<void> _insertMany({
    required String collectionId,
    required List<Map<String, dynamic>> values,
  }) async {
    if (values.isEmpty) return;
    final collection = await _getCollection(collectionId);
    final result = await collection.insertMany(values);
    if (result.hasWriteErrors) {
      // TODO: Log?
      throw 'Error inserting many into $_name: $collectionId\n';
    }
  }

  Future<void> _updateMany({
    required String collectionId,
    required List<(String, String)> selectors,
    required Map<String, dynamic> body,
  }) async {
    final collection = await _getCollection(collectionId);
    final result = await collection.updateMany({for (final selector in selectors) selector.$1: selector.$2}, body);
    if (result.hasWriteErrors) {
      // TODO: Log?
      throw 'Error updating many from $_name: $collectionId\n';
    }
  }

  Future<void> _deleteMany({
    required String collectionId,
    required List<(String, String)> selectors,
  }) async {
    final collection = await _getCollection(collectionId);
    final result = await collection.deleteMany({for (final selector in selectors) selector.$1: selector.$2});
    if (result.hasWriteErrors) {
      // TODO: Log?
      throw 'Error deleting many from $_name: $collectionId\n';
    }
  }

  Future<void> _insertNested({
    required String collectionId,
  }) async {}

  Future<void> _updateNested({
    required String collectionId,
  }) async {}

  Future<void> _deleteNested({
    required String collectionId,
  }) async {}
}
