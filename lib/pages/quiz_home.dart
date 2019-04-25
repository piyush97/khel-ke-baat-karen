import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

import '../data/dBProvider.dart';
import '../models/question_model.dart';

class TutorialHome extends StatefulWidget {
  @override
  _TutorialHomeState createState() => _TutorialHomeState();
}

class _TutorialHomeState extends State<TutorialHome> {
  var _answer;
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions"),
      ),
      body: FutureBuilder(
        future: DBProvider.db.getQuestion(123),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Question data = snapshot.data;
          if (data != null) _answer = data.answer;
          return Center(
            child: Container(
              color: Colors.white,
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
                            'Ye fake hai',
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
                                  image: data != null
                                      ? FileImage(File(data.imageFilePath))
                                      : NetworkImage(
                                          "https://www.homepersonalcareva.com/wp-content/uploads/2013/12/home-care-for-children-with-disabilities1.jpg"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            data != null
                                ? data.qTitle
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
                        color: Theme.of(context).secondaryHeaderColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                onClick("0");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 30),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(Icons.album),
                                    title: Text(
                                      data != null
                                          ? data.qOptions.split(",")[0]
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
                                onClick("1");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 20),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(Icons.album),
                                    title: Text(
                                      data != null
                                          ? data.qOptions.split(",")[1]
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
                                onClick("2");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 20),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(Icons.album),
                                    title: Text(
                                      data != null
                                          ? data.qOptions.split(",")[2]
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
                                onClick("3");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 20),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(Icons.album),
                                    title: Text(
                                      data != null
                                          ? data.qOptions.split(",")[3]
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
        },
      ),
    );
  }

  void onClick(String id) {
    print(_answer == id ? "Hurray correct answer " : "Wrong answer ");
  }
}
