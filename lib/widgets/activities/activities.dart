import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './activity_card.dart';
import '../../models/activity.dart';
import '../../scoped-models/main.dart';

class Activities extends StatelessWidget {
  Widget _buildActivityList(List<Activity> activities) {
    Widget activityCards;
    if (activities.length > 0) {
      activityCards = ListView.builder(
        scrollDirection: Axis.values[0],
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildActivityList(model.displayActivities);
      },
    );
  }
}
