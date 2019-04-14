import 'package:flutter/material.dart';

class ActivityCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ActivityCreatePageState();
  }
}

class _ActivityCreatePageState extends State<ActivityCreatePage> {
  String titleValue;
  String descriptionValue;
  double time;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          autofocus: true,
          onChanged: (String value) {
            setState(() {
              titleValue = value;
            });
          },
        ),
        TextField(
          maxLines: 4,
          onChanged: (String value) {
            setState(() {
              descriptionValue = value;
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          autocorrect: true,
          autofocus: true,
          onChanged: (String value) {
            setState(() {
              time = double.parse(value);
            });
          },
        ),
      ],
    );
  }
}
