import 'package:flutter/material.dart';
import 'dart:math';

class DragGame extends StatefulWidget {
  @override
  _DragGameState createState() => _DragGameState();
}

class _DragGameState extends State<DragGame> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  int rng = 0;

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    void changeIndex() {
      setState(() => rng = random.nextInt(100));
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("learn Odd and Even Numbers"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
                color: Colors.amber,
                child: Text("New Number?"),
                onPressed: () => changeIndex()),
            Draggable(
              data: rng,
              child: Container(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: Text(
                    rng.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                color: Colors.pink,
              ),
              feedback: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Center(
                    child: Text(
                      rng.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                  color: Colors.pinkAccent),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.green,
                  child: DragTarget(
                    builder: (context, List<int> candidateData, rejectedData) {
                      print(candidateData);
                      return Center(
                          child: Text(
                        "Even",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ));
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      print("data: $data");
                      if (data % 2 == 0) {
                        scaffoldKey.currentState
                            .showSnackBar(SnackBar(content: Text("Correct!")));
                      } else {
                        scaffoldKey.currentState
                            .showSnackBar(SnackBar(content: Text("Wrong!")));
                      }
                    },
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.deepPurple,
                  child: DragTarget(
                    builder: (context, List<int> candidateData, rejectedData) {
                      return Center(
                          child: Text(
                        "Odd",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ));
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      if (data % 2 != 0) {
                        scaffoldKey.currentState
                            .showSnackBar(SnackBar(content: Text("Correct!")));
                      } else {
                        scaffoldKey.currentState
                            .showSnackBar(SnackBar(content: Text("Wrong!")));
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
