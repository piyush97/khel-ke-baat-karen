import 'package:flutter/material.dart';

class TimeTag extends StatelessWidget {
  final String time;
  TimeTag(this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.5),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        'Time:$time',
        style: TextStyle(color: Colors.black, fontSize: 22),
      ),
    );
  }
}
