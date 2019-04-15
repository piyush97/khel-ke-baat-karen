import 'package:flutter/material.dart';

import './activity_edit.dart';

class ActivityListPage extends StatelessWidget {
  final List<Map<String, dynamic>> activities;

  ActivityListPage(this.activities);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        ListTile(
          leading: Image.asset(activities[index]['image']),
          title: Text(activities[index]['title']),
          trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ActivityEditPage(activity: activities[index]);
                    },
                  ),
                );
              }),
        );
      },
      itemCount: activities.length,
    );
  }
}
