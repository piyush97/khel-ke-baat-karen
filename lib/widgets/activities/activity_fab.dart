import 'package:flutter/material.dart';

class ActivityFAB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ActivityFABState();
  }
}

class _ActivityFABState extends State<ActivityFAB> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 70.0,
          width: 50.0,
          alignment: FractionalOffset.topCenter,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).cardColor,
            heroTag: 'contact',
            mini: true,
            onPressed: () {},
            child: Icon(Icons.mail, color:Theme.of(context).primaryColor),
          ),
        ),
        Container(
          height: 70.0,
          width: 50.0,
          alignment: FractionalOffset.topCenter,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).cardColor,
            heroTag: 'favorite',
            mini: true,
            onPressed: () {},
            child: Icon(Icons.favorite,color:Colors.red),
          ),
        ),
        Container(
          height: 70.0,
          width: 50.0,
          child: FloatingActionButton(
            heroTag: 'options',
            onPressed: () {},
            child: Icon(Icons.more_vert),
          ),
        ),
      ],
    );
  }
}
