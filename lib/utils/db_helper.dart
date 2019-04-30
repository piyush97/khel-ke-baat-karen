import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/activity_sqflite.dart';

class DatabaseHelper {
  static Database _database; // Singleton Database
  static DatabaseHelper _databaseHelper; //singleton database helper
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

  Future<List<Map<String, dynamic>>> getActivityMapList() async {
    Database db = await this.database;
    var result =
        await db.rawQuery('SELECT * FROM $activityTable'); //TODO: rawQuery
    // var result = await db.query(activityTable,orderBy: '')
  }

  // Insert Operation: Insert an Activity object to database
  Future<int> insertActivity(ActivitySQFLITE activity) async {
    Database db = await this.database;
    var result = await db.insert(activityTable, activity.toMap());
    return result;
  }

// Update Operation: Update a activity object and save it to database
  Future<int> updateActivity(ActivitySQFLITE activity) async {
    var db = await this.database;
    var result = await db.update(activityTable, activity.toMap(),
        where: '$colId = ?', whereArgs: [activity.id]);
    return result;
  }

  // Delete Operation: Delete a Activity object from database
  Future<int> deleteActivity(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $activityTable WHERE $colId = $id');
    return result;
  }

  // Get number of activity objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $activityTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
