import 'package:flutter/material.dart';
import 'dart:async';

import '../models/activity.dart';
import '../widgets/ui_elements/title_default.dart';

class ActivityPage extends StatelessWidget {
  final Activity activity;

  ActivityPage(this.activity);

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
      child: Scaffold(
        appBar: AppBar(
          title: Text(activity.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(activity.image),
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
      ),
    );
  }
}
