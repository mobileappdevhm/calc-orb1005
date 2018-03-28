import 'package:flutter/material.dart';
import 'logic.dart';

// This defines the layout of the application.
class CalcLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MainState mainState = MainState.of(context);
    //implements basic material design
    return new Scaffold(
      //top bar title
      appBar: new AppBar(
        title: new Text("Calculator"),
      ),
      body: new Column(
        children: <Widget>[
          //expands a child
          new Expanded(
            //combines positioning & sizing widgets
            child: new Container(
              color: Colors.black87,
              //padding from right corner
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
                  //all available buttons
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


  //button widgets
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

//this handles the button design and their on pressed function
class CalcButton extends StatelessWidget {
  CalcButton(String keyvalue) {
    this.keyvalue = keyvalue;

    //change the color of the operation buttons
    if (keyvalue == '÷' ||
        keyvalue == '×' ||
        keyvalue == '-' ||
        keyvalue == '+' ||
        keyvalue == '=') {
      fontColor = Colors.white70;
      buttonColor = Colors.orange;
    } //change the color of the top row buttons
      else if (keyvalue == 'AC' || keyvalue == '+/-' || keyvalue == '%') {
      buttonColor = Colors.white70;
    }
  }

  //color for remaining buttons
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
            //call on pressed function of main state object
            onPressed: () {
              mainState.onPressed(keyvalue);
            }),
      ),
    );
  }
}
