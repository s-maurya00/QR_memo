import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

import '../models/item.dart';

class DBHelper {
  static Database? _db;

  static const int _version = 1;
  static const String _tableName = "task";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}$_tableName.db';

      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "name STRING, descp TEXT, date STRING, "
            "notifyTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<int> insert(Item item) async {
    return await _db!.insert(_tableName, item.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static delete(Item item) async {
    await _db!.delete(_tableName, where: "id = ?", whereArgs: [item.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
      UPDATE $_tableName
      SET isCompleted = ?
      WHERE id = ?
    ''', [1, id]);
  }
}
