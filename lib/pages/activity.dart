import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

import '../models/activity.dart';
import '../scoped-models/activites.dart';
import '../widgets/ui_elements/title_default.dart';

class ActivityPage extends StatelessWidget {
  final int activityIndex;
  ActivityPage(this.activityIndex);

  Widget _buildActivityTimeRow(double time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Healthy Food',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          'Time: ' + time.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<ActivityModel>(
        builder: (BuildContext context, Widget child, ActivityModel model) {
          final Activity activities = model.activities[activityIndex];
          return Scaffold(
            appBar: AppBar(
              title: Text(activities.title),
            ),
            body: ListView(
              children: <Widget>[
                Image.asset(activities.image),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TitleDefault(activities.title),
                ),
                _buildActivityTimeRow(activities.time),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    activities.description,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
