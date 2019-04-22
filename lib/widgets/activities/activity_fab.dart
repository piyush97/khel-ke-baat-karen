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
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.more_vert),
        ),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
