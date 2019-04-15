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

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.98;
    final double targetPadding = deviceWidth - targetWidth;
    return Container(
      width: targetWidth,
      margin: EdgeInsets.all(10.0),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildTimeTextField(),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            child: Text('Create Activity'),
            onPressed: _submitForm,
          ),
          //@Todo: Gesture Detector
        ],
      ),
    );
  }

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

  void _submitForm() {
    final Map<String, dynamic> activity = {
      'title': _titleValue,
      'description': _descriptionValue,
      'time': _time,
      'image': 'assets/food.jpg'
    };
    widget.addActivity(activity);
    Navigator.pushReplacementNamed(context, '/activities');
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
}
