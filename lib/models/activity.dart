import 'package:flutter/material.dart';

class Activity {
  final String title;
  final String description;
  final double time;
  final String image;

  Activity({
    @required this.title,
    @required this.description,
    @required this.time,
    @required this.image,
  });
}
