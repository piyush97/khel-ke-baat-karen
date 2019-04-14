import 'package:flutter/material.dart';

import '../activity_manager.dart';

class ActivitiesPage extends StatelessWidget {
  final List<Map<String, dynamic>> activities;

  ActivitiesPage(this.activities);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              title: Text('Manage Activites'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Khel Ke Baat Karen'),
      ),
      body: ActivityManager(activities),
    );
  }
}
