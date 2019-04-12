import 'package:flutter/material.dart';
import './activity_manager.dart';
void main() => {runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lime,
        secondaryHeaderColor: Colors.amber
      ),
      home: Scaffold(
          appBar: AppBar(title: Text('Khel Ke Baat Karen')),
          body: ActivityManager('Food'),),
    );
  }
}
