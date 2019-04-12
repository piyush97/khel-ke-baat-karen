import 'package:flutter/material.dart';

void main() => {runApp(MyApp())};

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<String> activities = ['Food', 'Swimming'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('K2BK')),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('Finished?'),
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/food.jpg'),
                    Text('Food')
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
