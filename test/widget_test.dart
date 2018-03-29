// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calc_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that all buttons exist.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('×'), findsOneWidget);
    expect(find.text('÷'), findsOneWidget);


    // Calculate 9 + 9
    await tester.tap(find.text("9"));
    await tester.tap(find.text("+"));
    await tester.tap(find.text("9"));
    await tester.tap(find.text("="));
    await tester.pump();

    // Look if result is correct
    expect(find.text('18.0'), findsOneWidget);


    //calculate 4 x 2.5
    await tester.tap(find.text("4"));
    await tester.tap(find.text("×"));
    await tester.tap(find.text("2"));
    await tester.tap(find.text("."));
    await tester.tap(find.text("5"));
    await tester.tap(find.text("="));
    await tester.pump();

    // Look if result is correct
    expect(find.text('10.0'), findsOneWidget);

    // Multiple operators not allowed
    await tester.tap(find.text("4"));
    await tester.tap(find.text("×"));
    await tester.tap(find.text("+"));
    await tester.tap(find.text("-"));
    await tester.tap(find.text("5"));
    await tester.pump();

    // Look if result is correct
    expect(find.text('4×5'), findsOneWidget);
    await tester.tap(find.text("AC"));

    //no operators before number allowed
    await tester.tap(find.text("÷"));
    await tester.tap(find.text("5"));
    await tester.tap(find.text("÷"));
    await tester.tap(find.text("5"));
    await tester.pump();

    // Look if result is correct
    expect(find.text('5÷5'), findsOneWidget);
    await tester.tap(find.text("AC"));

    //multiple dots not allowed
    await tester.tap(find.text("."));
    await tester.tap(find.text("5"));
    await tester.tap(find.text("."));
    await tester.tap(find.text("."));
    await tester.tap(find.text("5"));
    await tester.tap(find.text("."));
    await tester.tap(find.text("."));
    await tester.pump();

    // Look if result is correct
    expect(find.text('5.5'), findsOneWidget);
  });
}
