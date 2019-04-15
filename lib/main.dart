import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/activity.dart';
import './pages/activites_admin.dart';
import './pages/activites.dart';
import './pages/auth.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _activities = [];

  void _addActivities(Map<String, dynamic> activity) {
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
        '/': (BuildContext context) => AuthPage(),
        '/activities': (BuildContext context) => ActivitiesPage(_activities),
        '/admin': (BuildContext context) =>
            ActivitiesAdminPage(_addActivities, _deleteActivities),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'activity') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ActivityPage(
                _activities[index]['title'], _activities[index]['image']),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => ActivitiesPage(_activities),
        );
      },
    );
  }
}
