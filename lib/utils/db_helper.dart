import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/activity_sqflite.dart';

class DatabaseHelper {
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
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $activityTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $coltime TEXT,$colimage TEXT, $colimagePath TEXT ) ');
  }
}
