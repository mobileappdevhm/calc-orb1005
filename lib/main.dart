import 'package:flutter/material.dart';
import 'logic.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of the application.
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

// Stateful Widget with mutable sates.
class Calculator extends StatefulWidget {
  @override
  CalcState createState() => new CalcState();
}
