import 'package:flutter/material.dart';

class ActivityCreatePage extends StatefulWidget {
  final Function addActivity;

  ActivityCreatePage(this.addActivity);

  @override
  State<StatefulWidget> createState() {
    return _ActivityCreatePageState();
  }
}

class _ActivityCreatePageState extends State<ActivityCreatePage> {
  String titleValue;
  String descriptionValue;
  double time;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(19.0),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Activity Name',
            ),
            autofocus: true,
            onChanged: (String value) {
              setState(() {
                titleValue = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Activity Description',
            ),
            maxLines: 4,
            onChanged: (String value) {
              setState(() {
                descriptionValue = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Activity Time',
            ),
            keyboardType: TextInputType.number,
            autocorrect: true,
            autofocus: true,
            onChanged: (String value) {
              setState(() {
                time = double.parse(value);
              });
            },
          ),
          RaisedButton(
            child: Text('Create Activity'),
            onPressed: () {
              final Map<String, dynamic> activity = {
                'title': titleValue,
                'description': descriptionValue,
                'time': time
              };
              widget.addActivity(activity);
            },
          )
        ],
      ),
    );
  }
}
