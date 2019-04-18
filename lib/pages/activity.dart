import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

import '../models/activity.dart';
import '../scoped-models/main.dart';
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
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Activity activity = model.allActivities[activityIndex];
          return Scaffold(
            appBar: AppBar(
              title: Text(activity.title),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(activity.image),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TitleDefault(activity.title),
                ),
                _buildActivityTimeRow(activity.time),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    activity.description,
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
