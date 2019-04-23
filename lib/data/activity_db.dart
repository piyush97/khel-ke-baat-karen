import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ActivityDatabase {
  static const ACTIVITY_TABLE_NAME = "activity";
  static final ActivityDatabase _instance = ActivityDatabase._internal();

  factory ActivityDatabase() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  ActivityDatabase._internal();

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "activity.db");
    var theDatabase = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDatabase;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE " +
        ACTIVITY_TABLE_NAME +
        " ("
        "id STRING PRIMARY KEY, "
        "title TEXT, "
        "time REAL, "
        "description TEXT, "
        "url TEXT, "
        "imagePath TEXT, "
        "isFavorite INT, "
        "userEmail TEXT, "
        "userId TEXT) ");
  }

  Future closeDb() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
