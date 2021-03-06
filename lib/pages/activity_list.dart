import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './activity_edit.dart';
import '../scoped-models/main.dart';

class ActivityListPage extends StatefulWidget {
  final MainModel model;

  ActivityListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ActivityListPageState();
  }
}

class _ActivityListPageState extends State<ActivityListPage> {
  @override
  initState() {
    widget.model.fetchActivities();
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectActivity(model.allActivities[index].id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ActivityEditPage();
            },
          ),
        ).then(
          (_) {
            model.selectActivity(null);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(model.allActivities[index].title),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  model.selectActivity(model.allActivities[index].id);
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
                          NetworkImage(model.allActivities[index].image),
                    ),
                    title: Text(model.allActivities[index].title),
                    subtitle: Text(
                        'Time:${model.allActivities[index].time.toString()}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider()
                ],
              ),
            );
          },
          itemCount: model.allActivities.length,
        );
      },
    );
  }
}
