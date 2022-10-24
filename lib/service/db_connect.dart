// ignore_for_file: file_names

import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_task");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE tbTask(ID TEXT PRIMARY KEY, title TEXT, note TEXT, isComplate INTEGER, date TEXT, startTime TEXT, endTime TEXT, remind TEXT, repead TEXT, color INTEGER)',
    );
  }
}
