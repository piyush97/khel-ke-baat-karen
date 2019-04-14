import 'package:flutter/material.dart';

import './activity_control.dart';
import './activities.dart';

class ActivityManager extends StatelessWidget {
  final List <Map<String, String>> activities;
  final Function addActivity;
  final Function deleteActivity;

  ActivityManager(this.activities, this.addActivity, this.deleteActivity);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: ActivityControl(addActivity),
        ),
        Expanded(child: Activities(activities, deleteActivity: deleteActivity))
      ],
    );
  }
}
