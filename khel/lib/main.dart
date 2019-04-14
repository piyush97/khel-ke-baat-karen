import 'package:flutter/material.dart';

import './pages/auth.dart';
import './pages/activites_admin.dart';
import './pages/activites.dart';

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
      routes: {
        '/': (BuildContext context) => ActivitiesPage(),
        '/admin': (BuildContext context) => ActivitiesAdminPage(),
      },
    );
  }
}
