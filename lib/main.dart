import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';

import './pages/activity.dart';
import './pages/activites_admin.dart';
import './pages/activites.dart';
import './pages/auth.dart';
import './scoped-models/main.dart';
import './models/activity.dart';

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
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.lime,
          secondaryHeaderColor: Colors.amber,
          buttonColor: Colors.yellow,
        ),
        // home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/activities': (BuildContext context) => ActivitiesPage(model),
          '/admin': (BuildContext context) => ActivitiesAdminPage(model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'activity') {
            final String activityId = pathElements[2];
            final Activity activity =
                model.allActivities.firstWhere((Activity activity) {
              return activity.id == activityId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ActivityPage(activity),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => ActivitiesPage(model),
          );
        },
      ),
    );
  }
}
