import 'package:flutter/material.dart';

import './activity_list.dart';
import './activity_edit.dart';
import '../scoped-models/main.dart';
import '../widgets/ui_elements/logout_list_tile.dart';

class ActivitiesAdminPage extends StatelessWidget {
  final MainModel model;

  ActivitiesAdminPage(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.assistant),
            title: Text('All Activities'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(),
          LogoutListTile()
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
            children: <Widget>[ActivityEditPage(), ActivityListPage(model)]),
      ),
    );
  }
}
