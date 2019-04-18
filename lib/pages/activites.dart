import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/activities/activities.dart';
import '../scoped-models/main.dart';

class ActivitiesPage extends StatefulWidget {
  final MainModel model;
  ActivitiesPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ActivitiesPageState();
  }
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  @override
  initState(){
    widget.model.fetchActivities();
    super.initState();
  }
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
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget widget, MainModel model) {
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
