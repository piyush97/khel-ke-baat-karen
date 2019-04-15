import 'package:flutter/material.dart';

import './pages/activity.dart';

class Activities extends StatelessWidget {
  final List<Map<String, dynamic>> activities;
  Activities(this.activities) {
    print('[Activities widget Constructor]');
  }

  Widget _buildActivityItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(activities[index]['image'] ?? ''),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              activities[index]['title'] ?? '',
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, fontFamily: 'Oswald'),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  child: Text('Details'),
                  onPressed: () => Navigator.pushNamed<bool>(
                      context, '/activity/' + index.toString()))
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
