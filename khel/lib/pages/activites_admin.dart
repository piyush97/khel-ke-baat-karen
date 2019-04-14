import 'package:flutter/material.dart';

import './activity_list.dart';
import './activity_create.dart';

class ActivitiesAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                title: Text('All Activities'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              )
            ],
          ),
        ),
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
            children: <Widget>[ActivityCreatePage(), ActivityListPage()]),
      ),
    );
  }
}
