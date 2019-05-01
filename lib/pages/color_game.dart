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
  };
}
