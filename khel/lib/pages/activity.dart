import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity Detail')),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/food.jpg'),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Details'),
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Back'),
                  onPressed: () => Navigator.pop(context),
                ))
          ],
        ),
      ),
    );
  }
}
