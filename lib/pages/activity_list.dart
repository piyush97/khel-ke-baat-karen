import 'package:flutter/material.dart';

import './activity_edit.dart';

class ActivityListPage extends StatelessWidget {
  final Function updateActivity;
  final List<Map<String, dynamic>> activities;

  ActivityListPage(this.activities, this.updateActivity);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(activities[index]['image']),
              ),
              title: Text(activities[index]['title']),
              subtitle: Text('Time: ${activities[index]['price'].toString()}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ActivityEditPage(
                          activity: activities[index],
                          updateActivity: updateActivity,
                          activityIndex: index,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Divider()
          ],
        );
      },
      itemCount: activities.length,
    );
  }
}
