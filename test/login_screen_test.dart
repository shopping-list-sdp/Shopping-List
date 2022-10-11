import 'package:shopping_list/screen/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.
  testWidgets('HomeScreen has a title and message', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MyWidget(title: 'T', message: 'M'));

    // Create the Finders.
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  testWidgets('HomeScreen input is working', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
        const MyWidget(title: 'This is a test', message: 'Message'));

    // Create the Finders.
    final titleFinder = find.text('This is a test');
    final messageFinder = find.text('Message');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  testWidgets('HomeScreen load asset correctly', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
        const MyWidget(title: 'asset has loaded', message: 'aseet is fine'));

    // Create the Finders.
    final titleFinder = find.text('asset has loaded');
    final messageFinder = find.text('aseet is fine');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  testWidgets('HomeScreen widget', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
        const MyWidget(title: 'this is the general widget test', message: 'M'));

    // Create the Finders.
    final titleFinder = find.text('this is the general widget test');
    final messageFinder = find.text('M');

    // Use the `findsOneWidget` matcher provided by flutter_test to
    // verify that the Text widgets appear exactly once in the widget tree.
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  group('Counter', () {
    test('value before loading assets', () {
      expect(AssetsForScreen().value, 0);
    });

    test('value should be incremented after laoding 1 assset', () {
      final counter = AssetsForScreen();

      counter.increment();

      expect(counter.value, 1);
    });

    test('when error', () {
      final counter = AssetsForScreen();

      counter.decrement();

      expect(counter.value, -1);
    });
  });
}
