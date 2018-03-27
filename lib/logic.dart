import 'package:flutter/material.dart';
import 'main.dart';
import 'layout.dart';

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

