import 'package:flutter/material.dart';

import './activites.dart';

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
                title: Text('All Products'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ActivitiesPage()));
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
        body: Text(
            children: <Widget>[ActivityCreatePage(), ActivityListPage()],
            'Test'),
      ),
    );
  }
}
