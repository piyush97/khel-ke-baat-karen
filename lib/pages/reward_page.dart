import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/dBProvider.dart';
import '../models/reward_model.dart';

class Reward extends StatefulWidget {
  @override
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  final _minPoints = TextEditingController();
  File _image;
  bool _hasData = false;

  @override
  initState() {
    super.initState();
    _getPreviousRewardSetting();
  }

  _getPreviousRewardSetting() async {
    try {
      RewardModel rewardModel = await DBProvider.db.getReward(1);
      _minPoints.text = rewardModel.rewardPoints;
      setState(() {
        _image = File(rewardModel.imagePath);
        _hasData = true;
      });
    } on NoSuchMethodError {
      print("Error occured");
    }
  }

  Future getImageFromGalerry() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image);
    setState(() {
      _image = image;
    });
    Navigator.pop(context);
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image);
    setState(() {
      _image = image;
    });
    Navigator.pop(context);
  }

  Future _saveData() async {
    RewardModel reward = RewardModel(
        id: 1, imagePath: _image.path, rewardPoints: _minPoints.text);
    if (!_hasData) {
      await DBProvider.db.newReward(reward);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: (MediaQuery.of(context).size.width) * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Choose a image ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('Camera'),
                                onTap: () {
                                  getImageFromCamera();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.movie_filter),
                                title: Text('Galery'),
                                onTap: () {
                                  getImageFromGalerry();
                                },
                              ),
                            ],
                          );
                        },
                        context: context);
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width) * .25,
                    height: (MediaQuery.of(context).size.width) * .25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            // change this to AssetImage if in localStorage
                            image: _image == null
                                ? AssetImage('assets/reward.png')
                                : FileImage(_image))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                  child: Text(
                    "Select a Image represents the reward ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.purple,
            width: (MediaQuery.of(context).size.width) * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Set minimum points needed for getting this reward.",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                  child: TextFormField(
                    controller: _minPoints,
                    decoration: InputDecoration(
                        labelText: "Minimun points needed.",
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide())),
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: FloatingActionButton.extended(
                    label: Text(
                      "save",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _saveData().then((_) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Reward settings!!"),
                                content: Text(
                                    "Reward settings saved or updated if alredy exist!!"),
                                actions: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Dismiss",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )
                                ],
                              );
                            });
                      });
                    },
                    icon: Icon(Icons.done),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
