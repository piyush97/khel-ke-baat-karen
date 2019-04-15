import 'package:flutter/material.dart';

class ActivityEditPage extends StatefulWidget {
  final Function addActivity;
  final Function updateActivity;
  final Map<String, dynamic> activity;
  final int activityIndex;

  ActivityEditPage(
      {this.addActivity,
      this.updateActivity,
      this.activity,
      this.activityIndex});

  @override
  State<StatefulWidget> createState() {
    return _ActivityEditPageState();
  }
}

class _ActivityEditPageState extends State<ActivityEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'time': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
        initialValue: widget.activity == null ? '' : widget.activity['title'],
        decoration: InputDecoration(
          labelText: 'Activity Name',
        ),
        autofocus: true,
        validator: (String value) {
          if (value.isEmpty || value.length > 20) {
            return 'Activity Title is Required and should be lesser than 20 characters';
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        });
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      initialValue:
          widget.activity == null ? '' : widget.activity['description'],
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Activity Description',
      ),
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.activity == null) {
      widget.addActivity(_formData);
    } else {
      widget.updateActivity(widget.activityIndex,_formData);
    }
    Navigator.pushReplacementNamed(context, '/activities');
  }

  Widget _buildTimeTextField() {
    return TextFormField(
      initialValue:
          widget.activity == null ? '' : widget.activity['time'].toString(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Required and should be 12 hour clock time';
        }
      },
      decoration: InputDecoration(
        labelText: 'Activity Time',
      ),
      keyboardType: TextInputType.number,
      autocorrect: true,
      autofocus: true,
      onSaved: (String value) {
        _formData['time'] = double.parse(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 500 : deviceWidth * 0.98;
    final double targetPadding = deviceWidth - targetWidth;
    final Widget pageContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: targetWidth,
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
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
        ),
      ),
    );
    return widget.activity == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Activity'),
            ),
            body: pageContent,
          );
  }
}
