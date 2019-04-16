import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/activity.dart';
import './pages/activites_admin.dart';
import './pages/activites.dart';
import './pages/auth.dart';
import './models/activity.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lime,
        secondaryHeaderColor: Colors.amber,
        buttonColor: Colors.yellow,
      ),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/activities': (BuildContext context) => ActivitiesPage(),
        '/admin': (BuildContext context) => ActivitiesAdminPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'activity') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) =>
                ActivityPage(null, null, null, null),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => ActivitiesPage(),
        );
      },
    );
  }
}
