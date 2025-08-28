import 'package:flutter_test_example/counter.dart';
import 'package:test/test.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });

  test('Counter value should be decremented', () {
    final counter = Counter();

    counter.decrement();

    expect(counter.value, -1);
  });
  test('Counter value should start at zero', () {
    final counter = Counter();

    expect(counter.value, 0);
  });
}
