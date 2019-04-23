import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

class ActivityDatabase {
  static const EVENT_TABLE_NAME = "activity";
  static final ActivityDatabase _instance = ActivityDatabase._internal();
  factory ActivityDatabase() => _instance;

  static Database _db;

  ActivityDatabase._internal();

  Future<Database> initD() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "activity.db");
  }
}
