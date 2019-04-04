import 'package:flutter/material.dart';
import 'package:cubef';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubef Sample',
      home: Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = 100.0, height = 100.0;

    GlobalKey<Cubef> cubef = GlobalKey<Cubef>();


   return Scaffold(
      body: Center(
        child: Cubef(
          key: cubef,
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
          height: 100.0,
          width: 100.0,
          controller: null,
       )),
    );
  }
}
