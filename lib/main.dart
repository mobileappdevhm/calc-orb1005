import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Calculator',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              color: Colors.lightGreen,
              child: new Align(
                alignment: Alignment.centerRight,
                child: new Text(
                  "80 * 20",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 50.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
