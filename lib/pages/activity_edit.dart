import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
    'image': 'assets/food.jpg',
    'day': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  

  Widget _buildTitleTextField(Activity activity) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: 'Activity Title'),
        initialValue: activity == null ? '' : activity.title,
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
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        maxLines: 4,
        decoration: InputDecoration(labelText: 'Product Description'),
        initialValue: activity == null ? '' : activity.description,
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

  Widget _buildPriceTextField(Activity activity) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Activity Time'),
        initialValue: activity == null ? '' : activity.time.toString(),
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

  File _imageFile;

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(
      source: source,
      maxWidth: 400.0,
    ).then((File image) {
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 150.0,
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Pick an Image',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    child: Text('Use Camera'),
                    onPressed: () {
                      _getImage(context, ImageSource.camera);
                    },
                    textColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text('Use Gallery'),
                    onPressed: () {
                      _getImage(context, ImageSource.gallery);
                    },
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ));
        });
  }

  Widget _imageInput() {
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt),
              SizedBox(width: 5.0),
              Text("Add Image",
                  style: TextStyle(color: Theme.of(context).accentColor)),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        _imageFile == null
            ? Text('Please Pick an Image')
            : Image.file(_imageFile,
                fit: BoxFit.cover,
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter),
      ],
    );
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
              _buildPriceTextField(activity),
              SizedBox(
                height: 10.0,
              ),
              _imageInput(),
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
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (selectedActivityIndex == -1) {
      addActivities(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['time'],
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
                  title: Text('Great!'),
                  content: Text("Activity Added"),
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
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['time'],
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
