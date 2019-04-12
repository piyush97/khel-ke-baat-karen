import 'package:flutter/material.dart';

import './activity_control.dart';
import './activities.dart';

class ActivityManager extends StatefulWidget {
  final String startingActivity;

  ActivityManager(this.startingActivity);

  @override
  State<StatefulWidget> createState() {
    return _ActivityManagerState();
  }
}

class _ActivityManagerState extends State<ActivityManager> {
  List<String> _activities = [];

  @override
  void initState() {
    super.initState();
    _activities.add(widget.startingActivity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: ActivityControl(),
        ),
        Activities(_activities)
      ],
    );
  }
}
