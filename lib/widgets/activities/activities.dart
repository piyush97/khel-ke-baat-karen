import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './activity_card.dart';
import '../../models/activity.dart';
import '../../scoped-models/activites.dart';

class Activities extends StatelessWidget {
  Widget _buildActivityList(List<Activity> activities) {
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
    return ScopedModelDescendant<ActivityModel>(
      builder: (BuildContext context, Widget child, ActivityModel model) {
        return _buildActivityList(model.displayActivities);
      },
    );
  }
}
