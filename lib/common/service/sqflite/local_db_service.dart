import 'dart:developer';
import 'dart:io';

import 'package:assign_khalti/common/constant/constant_text.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class LocalDBService {
  LocalDBService._privateConstructor();

  static final LocalDBService instance = LocalDBService._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    String path = "";
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
      path = "/assets/db";
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      path = join(directory.path, DBConstant.databaseName);
    }
    if (kDebugMode) {
      log("db stored path => $path");
    }
    return await openDatabase(path,
        version: DBConstant.dbVersion, onCreate: onCreate);
  }

  Future<void> deleteSQLiteDB({required String dbTableName}) async {
    Database? db = await instance.database;
    await db!.delete(dbTableName);
  }

  Future<void> onCreate(Database db, int version) async {
    /// Bank List
    await db.execute('''
      CREATE TABLE if not exists ${DBConstant.bankListTable}(${DBConstant.idx} TEXT ,
                                                ${DBConstant.bankName} TEXT,
                                                ${DBConstant.shortName} TEXT ,
                                                ${DBConstant.logo} TEXT,
                                                ${DBConstant.swiftCode} TEXT,
                                                ${DBConstant.address} TEXT)
                                               
      ''');
  }
}
