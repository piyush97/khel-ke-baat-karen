// import 'dart:async';
// import 'dart:collection';
// import '../models/activity.dart';
// import './activity_db.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ActivityRepository {
//   // for time
//   static const ACTIVITY_TABLE_NAME = "event";
//   static const String KEY_LAST_FETCH = "last_fetch";
//   static const int MILLISECONDS_IN_HOUR = 3600000;
//   static const int REFRESH_THRESHOLD = 3 * MILLISECONDS_IN_HOUR;

//   static Future<List<Activity>> _getActivitiesromDatabase() async {
//     Database dbClient = await ActivityDatabase().db;
//     List<Map<String, dynamic>> eventRecords =
//         await dbClient.query(ACTIVITY_TABLE_NAME);
//     // return eventRecords.map((record) => Activity.fromMap(record)).toList();  @TODO: fromMap
//   }
// }
