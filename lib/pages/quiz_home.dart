import 'package:flutter/material.dart';
import '../pages/add_question.dart';
import '../pages/reward_page.dart';
import '../pages/question_object.dart';

class TutorialHome extends StatefulWidget {
  @override
  _TutorialHomeState createState() => _TutorialHomeState();
}

class _TutorialHomeState extends State<TutorialHome> {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return QuestionObj();
  }
}
