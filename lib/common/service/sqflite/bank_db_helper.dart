import 'dart:io';

import 'package:assign_khalti/common/constant/constant_text.dart';
import 'package:assign_khalti/common/service/sqflite/local_db_service.dart';
import 'package:assign_khalti/src/home/model/bank_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class BankDBHelper {
  BankDBHelper._privateConstructor();

  static final BankDBHelper instance = BankDBHelper._privateConstructor();
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

    return await openDatabase(
      path,
      version: DBConstant.dbVersion,
      onCreate: LocalDBService.instance.onCreate,
    );
  }

  checkDatabaseData() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> mapData =
        await db!.rawQuery(''' SELECT * FROM ${DBConstant.bankListTable}''');
    if (mapData.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> insertData(BankModel data) async {
    Database? db = await instance.database;

    return await db!.insert(
        DBConstant.bankListTable,
        {
          DBConstant.idx: data.idx,
          DBConstant.bankName: data.name,
          DBConstant.shortName: data.shortName.isEmpty ? "" : data.shortName,
          DBConstant.logo: data.logo.isEmpty ? "" : data.logo,
          DBConstant.address: data.address,
          DBConstant.swiftCode: data.swiftCode,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateData(BankModel data) async {
    Database? db = await instance.database;
    return await db!.update(DBConstant.bankListTable, data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: "${DBConstant.bankName}=?",
        whereArgs: [data.name]);
  }

  Future deleteData({required String bankId}) async {
    Database? db = await instance.database;
    return await db!.rawQuery(
        ''' DELETE FROM ${DBConstant.bankListTable} WHERE ${DBConstant.idx} = "$bankId" ''');
  }

  Future<int> deleteAllData() async {
    Database? db = await instance.database;
    return await db!.delete(DBConstant.bankListTable);
  }

  Future<List<BankModel>> getDataList() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> mapData =
        await db!.rawQuery('''SELECT * FROM ${DBConstant.bankListTable} ''');

    return List.generate(mapData.length, (i) {
      return BankModel.fromJson(mapData[i]);
    });
  }
}
