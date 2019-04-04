import 'package:flutter/material.dart';
import 'package:cubef/cubef.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubef Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Cubef Widget Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<CubefState> cubefKey = new GlobalKey<CubefState>();
  
  void rollDown() {
    cubefKey.currentState.rollDown();
  }

  void rollUp() {
    cubefKey.currentState.rollUp();
  }

  void rollLeft() {
    cubefKey.currentState.rollLeft();
  }

  void rollRight() {
    cubefKey.currentState.rollRight();
  }

  @override
  Widget build(BuildContext context) {
    double width = 100.0, height = 100.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Cubef(
            key: cubefKey,
            animationEffect: Curves.decelerate,
            animationDuration: 500,
            child1: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Text("1"),
            ),
            child2: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.green[500],
              ),
              child: Text("2"),
            ),
            child3: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.orange[500],
              ),
              child: Text("3"),
            ),
            child4: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.blue[500],
              ),
              child: Text("4"),
            ),
            child5: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.pink[500],
              ),
              child: Text("5"),
            ),
            child6: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.purple[500],
              ),
              child: Text("6"),
            ),
            width: 100,
            height: 100,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            RaisedButton(onPressed: rollUp, child: Text('Roll Up')),
            RaisedButton(onPressed: rollDown, child: Text('Roll Down')),
            RaisedButton(onPressed: rollLeft, child: Text('Roll Left')),
            RaisedButton(onPressed: rollRight, child: Text('Roll Right')),
          ],)
        ],
      ),
    );
  }
}
