import 'package:flutter/material.dart';

import './pages/auth.dart';
import './pages/activites_admin.dart';
import './pages/activites.dart';
import './activities.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.lime,
          secondaryHeaderColor: Colors.amber),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) => ActivitiesPage(),
        '/admin': (BuildContext context) => ActivitiesAdminPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute(
            builder: (BuildContext context) => ActivityPage(
                activities[index]['title'], activities[index]['image']),
          );
        }
        return null;
      },
    );
  }
}
