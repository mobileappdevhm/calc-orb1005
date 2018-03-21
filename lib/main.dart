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
              color: Colors.black87,
              padding: const EdgeInsets.all(10.0),
              child: new Align(
                alignment: Alignment.centerRight,
                child: new Text(
                  "80 * 20",
                  style: new TextStyle(fontSize: 50.0, color: Colors.white70),
                ),
              ),
            ),
          ),
          new Expanded(
            flex: 3,
            child: new Container(
              color: Colors.black87,
              child: new Column(
                children: <Widget>[
                  makeButtons("C_%/"),
                  makeButtons("789x"),
                  makeButtons("456-"),
                  makeButtons("123+"),
                  makeButtons("0,=")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeButtons(String row) {
    List<String> token = row.split("");
    return new Expanded(
      flex: 1,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: token.map((e) => new CalcButton(keyvalue: e)).toList(),
      ),
    );
  }
}

class CalcButton extends StatelessWidget {
  CalcButton({this.keyvalue});

  final String keyvalue;

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        margin: const EdgeInsets.all(0.5),
        child: new FlatButton(
            color: Colors.white,
            child: new Center(
              child: new Text(
                keyvalue,
                style: new TextStyle(fontSize: 30.0),
              ),
            ),
            onPressed: () {}),
      ),
    );
  }
}
