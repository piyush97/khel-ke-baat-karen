import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/question_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Questions ("
          "id INTEGER PRIMARY KEY,"
          "q_title TEXT,"
          "q_options TEXT,"
          "answer TEXT,"
          "image_file_path TEXT"
          ")");
    });
  }

  newQuestion(Question newClient) async {
    final db = await database;
    var res = await db.insert("Questions", newClient.toMap());
    return res;
  }

  getQuestion(int id) async {
    final db = await database;
    var res = await db.query("Questions", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Question.fromMap(res.first) : null;
  }

  Future<List<Question>> getAllQuestions() async {
    final db = await database;
    var res = await db.query("Questions");

    List<Question> list =
        res.isNotEmpty ? res.map((c) => Question.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Questions", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Questions");
  }
}
