import 'package:flutter/material.dart';

import '../activity_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Khel Ke Baat Karen')),
      body: ActivityManager(),
    );
  }
}
