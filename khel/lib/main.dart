import 'package:flutter/material.dart';

void main() => {runApp(MyApp())};

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<String> _activities = ['Food'];

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
                  onPressed: () {
                    setState(() {
                      _activities.add('Advanced Activites');
                      print(_activities);
                    });
                  },
                  child: Text('Finished?'),
                ),
              ),
              Column(
                children: _activities
                    .map((element) => Card(
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/food.jpg'),
                              Text(element)
                            ],
                          ),
                        ))
                    .toList(),
              )
            ],
          )),
    );
  }
}
