import 'package:flutter/material.dart';
import 'dart:async';

import '../models/activity.dart';
import '../widgets/ui_elements/title_default.dart';
import '../widgets/activities/activity_fab.dart';

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
        // appBar: AppBar(
        //   title: Text(activity.title),
        // ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 256.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  activity.title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                ),
                background: Hero(
                  tag: activity.id,
                  child: FadeInImage(
                    image: NetworkImage(activity.image),
                    height: 400,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/food.jpg'),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      child: TitleDefault(activity.title)),
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
          ],
        ),
        floatingActionButton: ActivityFAB(activity),
      ),
    );
  }
}
