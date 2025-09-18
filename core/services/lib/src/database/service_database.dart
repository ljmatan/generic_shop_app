import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:sqflite_common/sqlite_api.dart' as sqflite_api;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart' as sqflite_ffi_web;

///
///
class GsaServiceDatabase extends GsaService {
  GsaServiceDatabase._();

  static final _instance = GsaServiceDatabase._();

  /// Globally-accessible class instance.
  ///
  static GsaServiceDatabase get instance => _instance() as GsaServiceDatabase;

  late sqflite_api.Database _db;

  @override
  Future<void> init(BuildContext context) async {
    await super.init(context);
    sqflite_ffi.sqfliteFfiInit();
    final appDocumentsDir = await path_provider.getApplicationDocumentsDirectory();
    final dbPath = path.join(appDocumentsDir.path, 'databases', 'gsa.db');
    _db = kIsWasm || kIsWeb
        ? await sqflite_ffi_web.databaseFactoryFfiWeb.openDatabase(dbPath)
        : await sqflite_ffi.databaseFactoryFfi.openDatabase(dbPath);
    // await _db.execute(
    //   '''
    //   CREATE TABLE Product (
    //       id INTEGER PRIMARY KEY,
    //       title TEXT
    //   )
    //   ''',
    // );
  }
}
