import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
  initState() {
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

  Widget _buildActivitiesList() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Center(child: Text('No Activities for Now!'));
        if (model.displayActivities.length > 0 && !model.isLoading) {
          content = Activities();
        } else if (model.isLoading) {
          content = Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
            onRefresh: model.fetchActivities, child: content);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = new FlutterTts();
    flutterTts.speak('hello');
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Khel Ke Baat Karen',
        ),
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
      body: _buildActivitiesList(),
      floatingActionButton: FloatingActionButton(
        child: Text('Points'),
        onPressed: () {SimpleDialog(title: Text(
          "Loooser"
        ),);},
      ),
    );
  }
}
