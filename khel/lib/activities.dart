import 'package:flutter/material.dart';

class Activites extends StatelessWidget {
  @override
  Widget build(BuildContext context){
   return Column(
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
              }
}