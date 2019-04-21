import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './time.dart';
import '../ui_elements/title_default.dart';
import '../../models/activity.dart';
import '../../scoped-models/main.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final int activityIndex;
  ActivityCard(this.activity, this.activityIndex);

  Widget _buildTitleTimeRow() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TitleDefault(activity.title),
          SizedBox(
            width: 8.0,
          ),
          TimeTag(activity.time.toString()),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            color: Theme.of(context).accentColor,
            onPressed: () => Navigator.pushNamed<bool>(
                context, '/activity/' + model.allActivities[activityIndex].id),
          ),
          IconButton(
            icon: Icon(model.allActivities[activityIndex].isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            color: Colors.red,
            onPressed: () {
              model.selectActivity(model.allActivities[activityIndex].id);
              model.toggleActivityFavoriteStatus();
            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Card(
          margin: EdgeInsets.all(18.0),
          elevation: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(30.0),
                child: FadeInImage(
                  image: NetworkImage(activity.image),
                  height: 150.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.scaleDown,
                  placeholder: AssetImage('assets/loader.jpg'),
                ),
              ),
              _buildTitleTimeRow(),
              Text(activity.userEmail),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}
