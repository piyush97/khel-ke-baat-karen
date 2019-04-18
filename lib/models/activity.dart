import 'package:flutter/material.dart';

class Activity {
  final String id;
  final String title;
  final String description;
  final double time;
  final String image;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  Activity({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.time,
    @required this.image,
    @required this.userEmail,
    @required this.userId,
    this.isFavorite = false
  });
}
