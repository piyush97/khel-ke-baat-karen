import 'package:flutter/material.dart';

import './pages/activity.dart';

class Activities extends StatelessWidget {
  final List<Map<String, String>> activities;
  final Function deleteActivity;
  Activities(this.activities, {this.deleteActivity}) {
    print('[Activities widget Constructor]');
  }

  Widget _buildActivityItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(activities[index]['image'] ?? ''),
          Text(activities[index]['title'] ?? ''),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.push<bool>(
                      context,
                    ).then((bool value) {
                      if (value) {
                        deleteActivity(index);
                      }
                    }),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildActivityList() { 
    Widget activityCards;
    if (activities.length > 0) {
      activityCards = ListView.builder(
        itemBuilder: _buildActivityItem,
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
