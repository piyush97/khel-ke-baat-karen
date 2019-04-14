import 'package:flutter/material.dart';

class Activities extends StatelessWidget {
  final List<String> activities;

  Activities(this.activities) {
    print('[Activities widget Constructor]');
  }

  Widget _buildActivityItem(BuildContext context, int index) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.asset('assets/food.jpg'),
        Text(activities[index])
      ],
    ));
  }

  Widget _buildActivityList() {
    Widget activityCards;
    if (activities.length > 0) {
      activityCards = ListView.builder(
        itemBuilder: _buildActivityItem,
        itemCount: activities.length,
      );
    } else {
      activityCards =
          Center(child: Text('Yayyy! No activities to do for now!'));
    }
    return activityCards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildActivityList();
  }
}
