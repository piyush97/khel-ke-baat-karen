import 'package:flutter/material.dart';

import './time.dart';
import '../ui_elements/title_default.dart';

class ActivityCard extends StatelessWidget {
  final Map<String, dynamic> activity;
  final int activityIndex;
  ActivityCard(this.activity, this.activityIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(activity['image'] ?? ''),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TitleDefault(activity['title']),
                SizedBox(
                  width: 8.0,
                ),
                TimeTag(activity['time'].toString()),
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
                      '/activity/' + activityIndex.toString(),
                    ),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () => Navigator.pushNamed<bool>(
                      context,
                      '/activity/' + activityIndex.toString(),
                    ),
              )
            ],
          )
        ],
      ),
    );
  }
}
