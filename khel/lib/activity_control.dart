import 'package:flutter/material.dart';

class ActivityControl extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).secondaryHeaderColor,
      onPressed: () {
        setState(() {
          _activities.add('Advanced Activites');
          print(_activities);
        });
      },
      child: Text('Finished?'),
    );
  }
}
