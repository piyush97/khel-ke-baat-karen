import 'package:flutter/material.dart';

import './activity_list.dart';
import './activity_edit.dart';
import '../models/activity.dart';

class ActivitiesAdminPage extends StatelessWidget {
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            title: Text('All Activities'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/activities');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Activities'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create an Activity',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Child\'s activities',
              ),
            ],
          ),
        ),
        body: TabBarView(
            children: <Widget>[ActivityEditPage(), ActivityListPage()]),
      ),
    );
  }
}
