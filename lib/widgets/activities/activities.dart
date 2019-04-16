import 'package:flutter/material.dart';

import './activity_card.dart';
import '../../models/activity.dart';

class Activities extends StatelessWidget {
  final List<Activity> activities;
  Activities(this.activities);

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
