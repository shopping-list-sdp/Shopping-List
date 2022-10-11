import 'package:shopping_list/screens/test.dart';
import 'package:test/test.dart';

void main() {
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

  test('value should be incremented after laoding 1 assset', () {
    final counter = AssetsForScreen();

    counter.increment();

    expect(counter.value, 1);
  });

  test('value should be incremented after laoding 1 assset', () {
    final counter = AssetsForScreen();

    counter.increment();

    expect(counter.value, 1);
  });
}
