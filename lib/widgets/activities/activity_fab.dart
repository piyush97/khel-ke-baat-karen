import 'dart:math' as math;

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

class _ActivityFABState extends State<ActivityFAB>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

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
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _controller,
                  curve: Interval(0, 1, curve: Curves.easeOut),
                ),
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
                  child:
                      Icon(Icons.mail, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Container(
              height: 70.0,
              width: 50.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _controller,
                  curve: Interval(0, 0.1, curve: Curves.easeOut),
                ),
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
            ),
            Container(
              height: 70.0,
              width: 50.0,
              child: FloatingActionButton(
                heroTag: 'options',
                onPressed: () {
                  if (_controller.isDismissed) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget widget) {
                    return Transform(
                      alignment: FractionalOffset.center,
                      transform:
                          Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                      child: Icon(_controller.isDismissed
                          ? Icons.more_vert
                          : Icons.close),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
