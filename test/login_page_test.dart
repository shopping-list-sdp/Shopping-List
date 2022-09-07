import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/screens/login_screen.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(home: child);
  }

  testWidgets('Login Screen appearance', (WidgetTester tester) async {
    LoginScreen loginScreen = const LoginScreen();
    await tester.pumpWidget(makeTestableWidget(child: loginScreen));
  });
}
