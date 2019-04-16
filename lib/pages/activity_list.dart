import 'package:flutter/material.dart';

import './activity_edit.dart';
import '../models/activity.dart';

class ActivityListPage extends StatelessWidget {
  final Function updateActivity;
  final List<Activity> activities;
  final Function deleteActivity;

  ActivityListPage(this.activities, this.updateActivity, this.deleteActivity);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          onDismissed: (DismissDirection direction) {
            deleteActivity(index);
          },
          key: Key(
            activities[index].time.toString(),
          ),
          background: Container(color: Colors.red),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(activities[index].image),
                ),
                title: Text(activities[index].title),
                subtitle:
                    Text('Time: ${activities[index].time.toString()}'),
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
          ),
        );
      },
      itemCount: activities.length,
    );
  }
}
