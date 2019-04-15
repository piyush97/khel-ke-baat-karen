import 'package:flutter/material.dart';
import './time.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  activities[index]['title'] ?? '',
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Oswald'),
                ),
                SizedBox(
                  width: 8.0,
                ),
                TimeTag(activities[index]['time'].toString()),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.circular(6.0)),
            child: Padding(
              child: Text('Hurry Up!'),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.5),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pushNamed<bool>(
                      context,
                      '/activity/' + index.toString(),
                    ),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () => Navigator.pushNamed<bool>(
                      context,
                      '/activity/' + index.toString(),
                    ),
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