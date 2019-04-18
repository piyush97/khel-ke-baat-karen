import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './activity_edit.dart';
import '../scoped-models/activites.dart';

class ActivityListPage extends StatelessWidget {
  Widget _buildEditButton(
      BuildContext context, int index, ActivityModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectActivity(index);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ActivityEditPage();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ActivityModel>(
      builder: (BuildContext context, Widget child, ActivityModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.activities[index].title),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectActivity(index);
                  model.deleteActivities();
                } else if (direction == DismissDirection.startToEnd) {
                  print('Swiped start to end');
                } else {
                  print('Other swiping');
                }
              },
              background: Container(color: Colors.red),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage(model.activities[index].image),
                    ),
                    title: Text(model.activities[index].title),
                    subtitle:
                        Text('\$${model.activities[index].time.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.activities.length,
        );
      },
    );
  }
}
