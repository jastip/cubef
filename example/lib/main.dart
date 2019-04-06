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

  static double _width = 100.0, _height = 100.0;

  List<Widget> sides = [
    Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: Colors.black
      ),
      child: Text("1"),
    ),
    Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: Colors.green[500],
      ),
      child: Text("2"),
    ),
    Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: Colors.orange[500],
      ),
      child: Text("3"),
    ),
    Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: Colors.blue[500],
      ),
      child: Text("4"),
    ),
    Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: Colors.pink[500],
      ),
      child: Text("5"),
    ),
    Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: Colors.purple[500],
      ),
      child: Text("6"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Cubef(
            key: cubefKey,
            animationDuration: 2000,
            sides: sides,
            width: _width,
            height: _height,
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
