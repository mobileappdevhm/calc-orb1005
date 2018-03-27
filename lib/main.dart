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
      home: new Calculator(),
    );
  }
}

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

class Calculator extends StatefulWidget {
  @override
  CalcState createState() => new CalcState();
}

class CalcState extends State<Calculator> {
  String inputString = " ";
  double prevValue;
  String value = "";
  String operator = null;
  String dot = null;

  bool isNumber(String str){
    if (str == null){
      return false;
    }
    return double.parse(str, (error) => null) != null;
  }

  void onPressed(keyvalue) {
    switch (keyvalue) {
      case "AC":
        operator = null;
        dot = null;
        prevValue = 0.0;
        value = "";
        setState(() => inputString = "");
        break;
      case ".":
        if(dot == "z"){
          dot = keyvalue;
          setState(() {
            inputString = inputString + keyvalue;
          });
          value = value + keyvalue;
        }
        break;
      case "%":
      case "+/-":
        break;
      case "×":
      case "+":
      case "-":
      case "÷":
        if(operator == "z") {
          operator = keyvalue;
          value = '';
          prevValue = double.parse(inputString);
          dot = null;
          setState(() {
            inputString = inputString + keyvalue;
          });
        }
        break;
      case "=":
        if (operator != null) {
          setState(() {
            switch (operator) {
              case "×":
                inputString =
                    (prevValue * double.parse(value)).toStringAsFixed(0);
                break;
              case "+":
                inputString =
                    (prevValue + double.parse(value)).toStringAsFixed(0);
                break;
              case "-":
                inputString =
                    (prevValue - double.parse(value)).toStringAsFixed(0);
                break;
              case "÷":
                inputString =
                    (prevValue / double.parse(value)).toStringAsFixed(2);
                break;
            }
          });
          operator = null;
          dot = null;
          prevValue = double.parse(inputString);
          value = '';
          break;
        }
        break;
      default:
        if (isNumber(keyvalue)) {
          if (operator != null) {
            setState(() => inputString = inputString + keyvalue);
            value = value + keyvalue;
          } else {
            setState(() => inputString = "" + keyvalue);
            operator = 'z';
          }
          if(dot == null){
            dot = 'z';
          }
        } else {
          onPressed(keyvalue);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MainState(
        inputValue: inputString,
        prevValue: prevValue,
        value: value,
        operator: operator,
        dot: dot,
        onPressed: onPressed,
        child: new CalcLayout());
  }
}

class MainState extends InheritedWidget {
  MainState({
    Key key,
    this.inputValue,
    this.prevValue,
    this.value,
    this.operator,
    this.dot,
    this.onPressed,
    Widget child,
  })
      : super(key: key, child: child);

  final String inputValue;
  final double prevValue;
  final String value;
  final String operator;
  final String dot;
  final Function onPressed;

  static MainState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MainState);
  }

  @override
  bool updateShouldNotify(MainState oldWidget) {
    return inputValue != oldWidget.inputValue;
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
