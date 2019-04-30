import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/activity_sqflite.dart';

class DatabaseHelper {
  static Database _database; // Singleton Database
  static DatabaseHelper _databaseHelper;
  String activityTable = 'activity_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String coltime = 'time';
  String colimage = 'image';
  String colimagePath = 'imagePath';
  bool colisFavorite = false;

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'activities.db';

    var activityDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return activityDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $activityTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $coltime TEXT,$colimage TEXT, $colimagePath TEXT ) ');
  }
}
