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
    return activities.length > 0 ?ListView.builder(
      itemBuilder: _buildActivityItem,
      itemCount: activities.length,
    ) : Center(child: Text('Yayyy! No activities to do for now!')); 
  }
}
