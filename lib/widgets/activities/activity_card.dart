import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './time.dart';
import '../ui_elements/title_default.dart';
import './description_tag.dart';
import '../../models/activity.dart';
import '../../scoped-models/activites.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final int activityIndex;
  ActivityCard(this.activity, this.activityIndex);

  Widget _buildTitleTimeRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
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
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(
                context,
                '/activity/' + activityIndex.toString(),
              ),
        ),
        ScopedModelDescendant<ActivityModel>(
            builder: (BuildContext context, Widget child, ActivityModel model) {
          return IconButton(
            icon: Icon(model.activities[activityIndex].isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Colors.red,
            onPressed: () {
              model.selectActivity(activityIndex);
              model.toggleFavActivity();
            },
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(activity.image ?? ''),
          SizedBox(
            height: 10.0,
          ),
          _buildTitleTimeRow(),
          DescriptionTag('Swimming is good for health'),
          _buildActionButtons(context),
        ],
      ),
    );
  }
}
