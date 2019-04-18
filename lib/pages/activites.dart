import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/activities/activities.dart';
import '../scoped-models/activites.dart';

class ActivitiesPage extends StatelessWidget {
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Manage Activites'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Khel Ke Baat Karen'),
        actions: <Widget>[
          ScopedModelDescendant<ActivityModel>(
            builder:
                (BuildContext context, Widget widget, ActivityModel model) {
              return IconButton(
                icon: Icon(model.displayFavoritesOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          )
        ],
      ),
      body: Activities(),
    );
  }
}
