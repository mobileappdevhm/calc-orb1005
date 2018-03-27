import 'package:flutter/material.dart';
import 'logic.dart';

class CalcLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainState mainState = MainState.of(context);
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
                  mainState.inputValue ?? "0",
                  style: new TextStyle(fontSize: 50.0, color: Colors.white),
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
                  makeButtons("AC|+/-|%|÷"),
                  makeButtons("7|8|9|×"),
                  makeButtons("4|5|6|-"),
                  makeButtons("1|2|3|+"),
                  makeButtons("0|.|=")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeButtons(String row) {
    List<String> token = row.split("|");
    return new Expanded(
      flex: 1,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: token.map((e) => new CalcButton(e)).toList(),
      ),
    );
  }
}

class CalcButton extends StatelessWidget {
  CalcButton(String keyvalue) {
    this.keyvalue = keyvalue;

    if (keyvalue == '÷' ||
        keyvalue == '×' ||
        keyvalue == '-' ||
        keyvalue == '+' ||
        keyvalue == '=') {
      fontColor = Colors.white70;
      buttonColor = Colors.orange;
    } else if (keyvalue == 'AC' || keyvalue == '+/-' || keyvalue == '%') {
      buttonColor = Colors.white70;
    }
  }

  String keyvalue;
  Color fontColor = Colors.black87;
  Color buttonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final MainState mainState = MainState.of(context);
    return new Expanded(
      child: new Container(
        margin: const EdgeInsets.all(0.5),
        child: new FlatButton(
            color: buttonColor,
            child: new Center(
              child: new Text(
                keyvalue,
                style: new TextStyle(fontSize: 30.0, color: fontColor),
              ),
            ),
            onPressed: () {
              mainState.onPressed(keyvalue);
            }),
      ),
    );
  }
}