import 'package:flutter/material.dart';

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
          trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        );
      },
      itemCount: activities.length,
    );
  }
}
