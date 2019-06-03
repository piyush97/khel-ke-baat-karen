import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/dBProvider.dart';
import '../models/question_model.dart';

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _question = TextEditingController();
  final _option1 = TextEditingController();
  final _option2 = TextEditingController();
  final _option3 = TextEditingController();
  final _option4 = TextEditingController();

  String answerIndex = "1";

  File _image;

  Future getImageFromGalerry() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(image);
    setState(() {
      _image = image;
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width) * .6,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 0, left: 30, right: 30, top: 35),
              child: SingleChildScrollView(
                child: Form(
                    child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _question,
                      decoration: new InputDecoration(
                        labelText: "Enter the question for child",
                        fillColor: Colors.white,

                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Question cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "1) ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 50),
                              child: TextFormField(
                                controller: _option1,
                                decoration: InputDecoration(
                                    labelText: "Option 1",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide())),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 28, left: 28, right: 28),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "2) ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 50),
                              child: TextFormField(
                                controller: _option2,
                                decoration: InputDecoration(
                                    labelText: "Option 2",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide())),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 28, left: 28, right: 28),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "3) ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 50),
                              child: TextFormField(
                                controller: _option3,
                                decoration: InputDecoration(
                                    labelText: "Option 3",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide())),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 5, left: 28, right: 28),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "4) ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 50),
                              child: TextFormField(
                                controller: _option4,
                                decoration: InputDecoration(
                                    labelText: "Option 4",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide())),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Select correct option:    ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<String>(
                          value: answerIndex,
                          onChanged: (String newValue) {
                            setState(() {
                              answerIndex = newValue;
                            });
                          },
                          items: <String>['1', '2', '3', '4']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Container(
                      width: 200,
                      child: RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                        textColor: Colors.white,
                        color: Theme.of(context).accentColor,
                        child: new Text("Add"),
                        onPressed: () {
                          _collectData().then((_) {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 30),
            width: (MediaQuery.of(context).size.width) * .4,
            height: (MediaQuery.of(context).size.width) * .4,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: (MediaQuery.of(context).size.width) * .25,
                    height: (MediaQuery.of(context).size.width) * .25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            // change this to AssetImage if in localStorage
                            image: _image == null
                                ? AssetImage('assets/avtar.png')
                                : FileImage(_image))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            getImageFromCamera();
                          },
                          child: Text("Camera"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            getImageFromGalerry();
                          },
                          child: Text("Gallery"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    ));
  }

  Future _collectData() async {
    String question = _question.text,
        opt1 = _option1.text,
        opt2 = _option2.text,
        opt3 = _option3.text,
        opt4 = _option4.text,
        answer = answerIndex,
        imageFilePath = _image.path;
    print("$question \n$opt1\n$opt2\n$opt3\n$opt4\n$answer\n$imageFilePath");
    Question queObj = Question(
        answer: answer,
        imageFilePath: imageFilePath,
        qTitle: question,
        qOptions: "$opt1, $opt2, $opt3, $opt4");
    await DBProvider.db.newQuestion(queObj);
  }
}
