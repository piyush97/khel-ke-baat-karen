import 'package:flutter/material.dart';

class Activities extends StatelessWidget {
  final List<String> activities;

  Activities(this.activities);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activities
          .map(
            (element) => Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/food.jpg'),
                      Text(element)
                    ],
                  ),
                ),
          )
          .toList(),
    );
  }
}
