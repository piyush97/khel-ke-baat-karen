import 'package:flutter/material.dart';

class ActivityControl extends StatelessWidget {
  final Function addActivity;
  ActivityControl(this.addActivity);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).secondaryHeaderColor,
      onPressed: () {
        addActivity('Sleep');
      },
      child: Text('Finished?'),
    );
  }
}
