import 'package:flutter/material.dart';

import './activities.dart';

class ActivityManager extends StatelessWidget {
  final List<Map<String, dynamic>> activities;

  ActivityManager(this.activities);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: Activities(activities))],
    );
  }
}
