import 'dart:io';
import '../models/question_model.dart';

import '../data/dBProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/reward_model.dart';
import '../pages/add_question.dart';
import '../pages/reward_page.dart';

class QuestionObj extends StatefulWidget {
  @override
  _QuestionObjState createState() => _QuestionObjState();
}

enum TtsState { playing, stopped }

class _QuestionObjState extends State<QuestionObj> {
  int _index = 0;
  List<Question> _data;

  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;
  TtsState ttsState = TtsState.stopped;

  File _rewardImage;
  String _minRewardPoints;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
    print("initi Sate");
    _getRewardData();
  }

  initTts() {
    flutterTts = FlutterTts();

    if (Platform.isAndroid) {
      flutterTts.ttsInitHandler(() {
        _getLanguages();
        _getVoices();
      });
    } else if (Platform.isIOS) {
      _getLanguages();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    if (voices != null) setState(() => voices);
  }

  Future _speak(String _newVoiceText) async {
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  _getRewardData() async {}

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 140.0),
        child: FloatingActionButton(
          onPressed: () {
            if (_data.length > 0) {
              _speak(_data[_index].qTitle +
                  ". Options are, " +
                  _data[_index].qOptions);
            } else {
              _speak("No questions for now! Enjoy!");
            }
          },
          child: Icon(Icons.speaker),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: FutureBuilder(
        future: DBProvider.db.getAllQuestions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            _data = snapshot.data;
            String answer = (_data != null ? _data[_index].answer : "");
            print("datat lenght :${_data.length}, indes: $_index");

            return Center(
              child: Container(
                color: Color(0xFFFFFFFF),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width) * .5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Text(
                              'Question ${_index + 1}/${_data.length}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFfe1f6a),
                                  fontSize: 23),
                            ),
                          ),
                          Container(
                            width: 190.0,
                            height: 190.0,
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    // change this to AssetImage if in localStorage
                                    image: _data[_index] != null
                                        ? FileImage(
                                            File(_data[_index].imageFilePath))
                                        : NetworkImage(
                                            "https://www.homepersonalcareva.com/wp-content/uploads/2013/12/home-care-for-children-with-disabilities1.jpg"))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              _data[_index] != null
                                  ? _data[_index].qTitle
                                  : 'How was you experience with tranpoline? How do you feel today?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                  fontSize: 27),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width) * .5,
                      child: Center(
                        child: Container(
                          color: Color(0xFF4294ac),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  onClick("1", answer, context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 30),
                                  child: Card(
                                    child: ListTile(
                                      leading: Icon(Icons.album),
                                      title: Text(
                                        _data[_index] != null
                                            ? _data[_index]
                                                .qOptions
                                                .split(",")[0]
                                            : 'Option1',
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  onClick("2", answer, context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 20),
                                  child: Card(
                                    child: ListTile(
                                      leading: Icon(Icons.album),
                                      title: Text(
                                        _data[_index] != null
                                            ? _data[_index]
                                                .qOptions
                                                .split(",")[1]
                                            : 'Option2',
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  onClick("3", answer, context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 20),
                                  child: Card(
                                    child: ListTile(
                                      leading: Icon(Icons.album),
                                      title: Text(
                                        _data[_index] != null
                                            ? _data[_index]
                                                .qOptions
                                                .split(",")[2]
                                            : 'Option3',
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  onClick("4", answer, context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 20),
                                  child: Card(
                                    child: ListTile(
                                      leading: Icon(Icons.album),
                                      title: Text(
                                        _data[_index] != null
                                            ? _data[_index]
                                                .qOptions
                                                .split(",")[3]
                                            : 'Option4',
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      "There is no questions set please tell speatial educator to set it for you!!",
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  onClick(String id, String answer, BuildContext context) async {
    print(answer == id ? "Hurray correct answer " : "Wrong answer ");
    RewardModel rewardModel = await DBProvider.db.getReward(1);
    print("data is " + rewardModel.imagePath);
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Result of your attempt: ",
              style: TextStyle(fontSize: 25),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(answer == id
                    ? "Hurray Correct answer!!"
                    : "Wrong answer!!"),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Reward of todays quiz ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    width: 190.0,
                    height: 190.0,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          // change this to AssetImage if in localStorage
                          image: FileImage(File(rewardModel.imagePath))),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Minimum point required: " + rewardModel.rewardPoints,
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              RaisedButton(
                textColor: Colors.white,
                child: Text(
                    _index + 1 < _data.length ? "Next Question" : "End quiz"),
                onPressed: () {
                  if (_index + 1 < _data.length) {
                    setState(() {
                      _index = _index + 1;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
