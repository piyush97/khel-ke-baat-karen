import 'package:flutter/material.dart';

import './activity_control.dart';
import './activities.dart';

class ActivityManager extends StatefulWidget {
  final String startingActivity;

  ActivityManager({this.startingActivity}) {
    print('Activity manager contructor call');
  }

  @override
  State<StatefulWidget> createState() {
    return _ActivityManagerState();
  }
}

class _ActivityManagerState extends State<ActivityManager> {
  List<String> _activities = [];

  void _addActivities(String activity) {
    setState(() {
      _activities.add('Advanced Activites');
    });
  }

  @override
  void initState() {
    if (widget.startingActivity != null) {
    _activities.add(widget.startingActivity);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: ActivityControl(_addActivities),
        ),
        Expanded(child: Activities(_activities))
      ],
    );
  }
}
