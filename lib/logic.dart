import 'package:flutter/material.dart';
import 'main.dart';
import 'layout.dart';

// This defines the state of the calculator.
class CalcState extends State<Calculator> {
  String inputString = " "; //the string on the on the output field
  double prevValue; //the string on the left side of operator
  String value = ""; //the current value
  String operator = null; //this stores the operator for the calculation
  String dot = null; // this stores the dot for decimal numbers

  //this checks if the input is a number
  bool isNumber(String str){
    if (str == null){
      return false;
    }
    // check if the input is a number (parsable to double) => true, if not throw error => false
    return double.parse(str, (error) => null) != null;
  }

  // onPressed handles the various input cases accordingly
  void onPressed(keyvalue) {

    switch (keyvalue) {
      //if AC get pressed reset all values
      case "AC":
        operator = null;
        dot = null;
        prevValue = 0.0;
        value = "";
        setState(() => inputString = "");
        break;
      // only enable dot if one number was already written and only once
      case ".":
        if(dot == "z"){
          dot = keyvalue;
          //print value on output widget
          setState(() {
            inputString = inputString + keyvalue;
          });
          // remember value
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
        //allow operator only once
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
        //only calculate if there is an operator and two numbers
        if (operator != null) {
          setState(() {
            switch (operator) {
              case "×":
                inputString =
                    (prevValue * double.parse(value)).toString();
                break;
              case "+":
                inputString =
                    (prevValue + double.parse(value)).toString();
                break;
              case "-":
                inputString =
                    (prevValue - double.parse(value)).toString();
                break;
              case "÷":
                inputString =
                    (prevValue / double.parse(value)).toString();
                break;
            }
          });
          //reset values after calculation
          operator = null;
          dot = null;
          prevValue = 0.0;
          value = '';
          break;
        }
        break;
      default:
        //check if input is a number
        if (isNumber(keyvalue)) {
          //if input is a following number
          if (operator != null) {
            setState(() => inputString = inputString + keyvalue);
            value = value + keyvalue;
            //if input is first number
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

  //build a main state widget
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

//main state handles the calculations
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
  }) : super(key: key, child: child);

  final String inputValue;
  final double prevValue;
  final String value;
  final String operator;
  final String dot;
  final Function onPressed;


  //when the main state changes all of its instances will be replaced by the new one
  static MainState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MainState);
  }


  //this lets the widget notify its child widgets
  @override
  bool updateShouldNotify(MainState oldWidget) {
    return inputValue != oldWidget.inputValue;
  }
}

