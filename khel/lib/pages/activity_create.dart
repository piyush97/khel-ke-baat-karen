import 'package:flutter/material.dart';

class ActivityCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityCreatePageState();
  }
}

class _ActivityCreatePageState extends State<ActivityCreatePage> {
  String titleValue = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          autocorrect: true,
          autofocus: true,
          onChanged: (String value) {
            setState(() {
              titleValue = value;
            });
          },
        ),
        Text(titleValue)
      ],
    );
  }
}
