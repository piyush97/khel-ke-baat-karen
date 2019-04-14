import 'package:flutter/material.dart';
import 'package:khel/pages/activity.dart';

import './pages/activites_admin.dart';
import './pages/activites.dart';
import 'pages/activites.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> _activities = [];

  void _addActivities(Map<String, String> activity) {
    setState(() {
      _activities.add(activity);
    });
  }

  void _deleteActivities(int index) {
    setState(() {
      _activities.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.lime,
          secondaryHeaderColor: Colors.amber),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) =>
            ActivitiesPage(_activities, _addActivities, _deleteActivities),
        '/admin': (BuildContext context) => ActivitiesAdminPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'activity') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute(
            builder: (BuildContext context) => ActivityPage(
                _activities[index]['title'], _activities[index]['image']),
          );
        }
        return null;
      },
    );
  }
}
