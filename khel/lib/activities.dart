import 'package:flutter/material.dart';

class Activities extends StatelessWidget {
  final List<String> activities;

  Activities(this.activities) {
    print('[Activities widget Constructor]');
  }

  Widget _buildActivityItem(BuildContext context, int index) {
    return Card(
        child: Column(
      children: <Widget>[
        Image.asset('assets/food.jpg'),
        Text(activities[index])
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    print('Build');
    return ListView.builder(
      itemBuilder: _buildActivityItem,
      itemCount: activities.length,
    );
  }
}
