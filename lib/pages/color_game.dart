import 'package:flutter/material.dart';
import 'dart:math';

class ColorGame extends StatefulWidget {
  createState() => ColorGameState();
}

class ColorGameState extends State<ColorGame> {
  final Map<String, bool> score = {};
  final Map choice = {
    '🍏': Colors.green,
    '🍋': Colors.yellow,
    '🍅': Colors.red,
    '🍇': Colors.purple,
    '🍠': Colors.brown,
    '🥕': Colors.orange,
  };
  // Random seed to shuffle order of items
  int seed = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score ${score.length}/6'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear;
          });
        },
      ),
    );
  }
}
