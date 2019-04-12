import 'package:flutter/material.dart';

import './activities.dart';

class ActivityManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ActivityManagerState();
  }
}

class _ActivityManagerState extends State<ActivityManager> {
  List<String> _activities = ['Food'];
  @override
  Widget build(BuildContext context) {
    return Column(children: [Container(
      margin: EdgeInsets.all(8),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _activities.add('Advanced Activites');
            print(_activities);
          });
        },
        child: Text('Finished?'),
      ),
    ),
    Activities(_activities)
    ],) ;
  }
}
