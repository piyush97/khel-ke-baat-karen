import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/activity.dart';
import '../../scoped-models/main.dart';

class ActivityFAB extends StatefulWidget {
  final Activity activity;
  ActivityFAB(this.activity);

  @override
  State<StatefulWidget> createState() {
    return _ActivityFABState();
  }
}

class _ActivityFABState extends State<ActivityFAB> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 70.0,
              width: 50.0,
              alignment: FractionalOffset.topCenter,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).cardColor,
                heroTag: 'contact',
                mini: true,
                onPressed: () async {
                  final url = 'mailto:${widget.activity.userEmail}';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch';
                  }
                },
                child: Icon(Icons.mail, color: Theme.of(context).primaryColor),
              ),
            ),
            Container(
              height: 70.0,
              width: 50.0,
              alignment: FractionalOffset.topCenter,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).cardColor,
                heroTag: 'favorite',
                mini: true,
                onPressed: () {
                  model.toggleActivityFavoriteStatus();
                },
                child: Icon(
                    model.selectedActivity.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red),
              ),
            ),
            Container(
              height: 70.0,
              width: 50.0,
              child: FloatingActionButton(
                heroTag: 'options',
                onPressed: () {},
                child: Icon(Icons.more_vert),
              ),
            ),
          ],
        );
      },
    );
  }
}
