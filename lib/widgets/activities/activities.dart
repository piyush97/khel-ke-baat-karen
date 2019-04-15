import 'package:flutter/material.dart';

import './activity_card.dart';

class Activities extends StatelessWidget {
  final List<Map<String, dynamic>> activities;
  Activities(this.activities) {
    print('[Activities widget Constructor]');
  }

  Widget _buildActivityList() {
    Widget activityCards;
    if (activities.length > 0) {
      activityCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ActivityCard(activities[index], index),
        itemCount: activities.length,
      );
    } else {
      activityCards = Container();
    }
    return activityCards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildActivityList();
  }
}
