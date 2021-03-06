import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import '../widgets/form_inputs/image.dart';
import '../widgets/helpers/ensure_visible.dart';
import '../models/activity.dart';
import '../scoped-models/main.dart';

class ActivityEditPage extends StatefulWidget {
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
    'image': null,
    'day': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  final _timeTextController = TextEditingController();
  Widget _buildTitleTextField(Activity activity) {
    if (activity == null && _titleTextController.text.trim() == '') {
      _titleTextController.text = '';
    } else if (activity != null && _titleTextController.text.trim() == '') {
      _titleTextController.text = activity.title;
    } else if (activity != null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else if (activity == null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else {
      _titleTextController.text = '';
    }
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: 'Activity Title'),
        controller: _titleTextController,
        // initialValue: product == null ? '' : product.title,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty || value.length < 5) {
            return 'Title is required and should be 5+ characters long.';
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Activity activity) {
    if (activity == null && _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = '';
    } else if (activity != null &&
        _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = activity.description;
    }

    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        maxLines: 4,
        decoration: InputDecoration(labelText: 'Activity Description'),
        // initialValue: Activity == null ? '' : Activity.description,
        controller: _descriptionTextController,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty || value.length < 10) {
            return 'Description is required and should be 10+ characters long.';
          }
        },
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildTimeTextField(Activity activity) {
    if (activity == null && _timeTextController.text.trim() == '') {
      _timeTextController.text = '';
    } else if (activity != null && _timeTextController.text.trim() == '') {
      _timeTextController.text = activity.description;
    }
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Activity Time'),
        controller: _timeTextController,
        // initialValue: activity == null ? '' : activity.time.toString(),
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty) {
            return 'Activity Time not valid';
          }
        },
        onSaved: (String value) {
          _formData['time'] = double.parse(value);
        },
      ),
    );
  }

  void _setImage(File image) {
    _formData['image'] = image;
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RaisedButton(
                child: Text('Save'),
                textColor: Colors.white,
                onPressed: () => _submitForm(
                      model.addActivities,
                      model.updateActivities,
                      model.selectActivity,
                      model.selectedActivityIndex,
                    ),
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Activity activity) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(activity),
              _buildDescriptionTextField(activity),
              _buildTimeTextField(activity),
              SizedBox(
                height: 10.0,
              ),
              ImageInput(_setImage, activity),
              SizedBox(height: 10.0),
              _buildSubmitButton(),
              // GestureDetector(
              //   onTap: _submitForm,
              //   child: Container(
              //     color: Colors.green,
              //     padding: EdgeInsets.all(5.0),
              //     child: Text('My Button'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(Function addActivities, Function updateActivities,
      Function setSelectedActivity,
      [int selectedActivityIndex]) {
    if (!_formKey.currentState.validate() ||
        (_formData['image'] == null && selectedActivityIndex == -1)) {
      return;
    }
    _formKey.currentState.save();
    if (selectedActivityIndex == -1) {
      addActivities(
        _titleTextController.text,
        _descriptionTextController.text,
        _formData['image'],
        double.parse(_timeTextController.text),
      ).then(
        (bool success) {
          if (success) {
            Navigator.pushReplacementNamed(context, '/activities')
                .then((_) => setSelectedActivity(null));
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text("Please try again!"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                );
              },
            );
          }
        },
      );
    } else {
      updateActivities(
        _titleTextController.text,
        _descriptionTextController.text,
        _formData['image'],
        double.parse(_timeTextController.text),
      ).then(
        (_) => Navigator.pushReplacementNamed(context, '/activities').then(
              (_) => setSelectedActivity(null),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedActivity);
        return model.selectedActivityIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Activity'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
