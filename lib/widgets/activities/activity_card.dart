import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './time.dart';
import '../../models/activity.dart';
import '../../scoped-models/main.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  ActivityCard(this.activity);

  Widget _buildTitleTimeRow() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: Text(
              (activity.title),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28.0),
              softWrap: true,
            ),
          ),
          Flexible(
            child: SizedBox(
              width: 8.0,
            ),
          ),
          Flexible(child: TimeTag(activity.time.toString())),
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
            onPressed: () {
              model.selectActivity(activity.id);
              Navigator.pushNamed<bool>(context, '/activity/' + activity.id)
                  .then((_) => model.selectActivity(null));
            },
          ),
          IconButton(
            icon: Icon(
                activity.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Colors.red,
            onPressed: () {
              model.selectActivity(activity.id);
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
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 600,
        ),
        child: Center(
          child: Card(
            margin: EdgeInsets.all(18.0),
            elevation: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Hero(
                  tag: activity.id,
                  child: FadeInImage(
                    image: NetworkImage(activity.image),
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/loader.jpg'),
                  ),
                ),
                _buildTitleTimeRow(),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
