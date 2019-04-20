import 'package:flutter/material.dart';
import 'dart:async';

import '../models/activity.dart';
import '../widgets/ui_elements/title_default.dart';

class ActivityPage extends StatelessWidget {
  final Activity activity;

  ActivityPage(this.activity);

  Widget _buildActivityTimeRow(double time) {
    return Center(
      child: Text(
        'Time: ' + time.toString(),
        style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(activity.title),
        ),
        body: ListView(
          children: <Widget>[
            Image.network(
              activity.image,
              scale: 0.1,
              height: 400,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Center(child: TitleDefault(activity.title)),
            ),
            Center(
              child: _buildActivityTimeRow(activity.time),
            ),
            Center(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                        child: Center(
                      child: Text(
                        activity.description,
                        textAlign: TextAlign.center,
                      ),
                    ))))
          ],
        ),
      ),
    );
  }
}
