import 'package:flutter/material.dart';

import './activity_control.dart';
import './activities.dart';

class ActivityManager extends StatefulWidget {
  final Map<String, String> startingActivity;

  ActivityManager({this.startingActivity}) {
    print('Activity manager contructor call');
  }

  @override
  State<StatefulWidget> createState() {
    return _ActivityManagerState();
  }
}

class _ActivityManagerState extends State<ActivityManager> {
  List<Map<String, String>> _activities = [];

  @override
  void initState() {
    if (widget.startingActivity != null) {
      _activities.add(widget.startingActivity);
    }
    super.initState();
  }

  void _addActivities(Map<String, String> activity) {
    setState(() {
      _activities.add(activity);
    });
  }

  void _deleteActivities(int index) {
    setState(() {
      _activities.removeAt(index);
    });
  }

  @override
  void didUpdateWidget(ActivityManager oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: ActivityControl(_addActivities),
        ),
        Expanded(child: Activities(_activities, deleteActivity: _deleteActivities))
      ],
    );
  }
}
