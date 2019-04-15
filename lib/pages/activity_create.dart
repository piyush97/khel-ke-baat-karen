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
  String _titleValue;
  String _descriptionValue;
  double _time;

  Widget _buildTitleTextField() {
    return TextField(
        decoration: InputDecoration(
          labelText: 'Activity Name',
        ),
        autofocus: true,
        onChanged: (String value) {
          setState(() {
            _titleValue = value;
          });
        });
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Activity Description',
      ),
      maxLines: 4,
      onChanged: (String value) {
        setState(() {
          _descriptionValue = value;
        });
      },
    );
  }

  Widget _buildTimeTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Activity Time',
      ),
      keyboardType: TextInputType.number,
      autocorrect: true,
      autofocus: true,
      onChanged: (String value) {
        setState(() {
          _time = double.parse(value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(19.0),
      child: ListView(
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildTimeTextField(),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Text('Create Activity'),
            onPressed: () {
              final Map<String, dynamic> activity = {
                'title': _titleValue,
                'description': _descriptionValue,
                'time': _time,
                'image': 'assets/food.jpg'
              };
              widget.addActivity(activity);
              Navigator.pushReplacementNamed(context, '/activities');
            },
          )
        ],
      ),
    );
  }
}
