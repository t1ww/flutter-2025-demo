import 'package:flutter_test_example/counter.dart';
import 'package:test/test.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter();

    counter.increment();

    expect(counter.value, 1);
  });
  test('Counter value should be incremented by 2', () {
    final counter = Counter();

    counter.increment();
    counter.increment();

    expect(counter.value, 2);
  });
  test('Counter value should be incremented by 3', () {
    final counter = Counter();

    counter.increment();
    counter.increment();
    counter.increment();

    expect(counter.value, 3);
  });

  // Decrement
  test('Counter value should be decremented', () {
    final counter = Counter();

    counter.decrement();

    expect(counter.value, -1);
  });
  test('Counter value should be decremented by 2', () {
    final counter = Counter();

    counter.decrement();
    counter.decrement();

    expect(counter.value, -2);
  });
  test('Counter value should be decremented by 3', () {
    final counter = Counter();

    counter.decrement();
    counter.decrement();
    counter.decrement();

    expect(counter.value, -3);
  });
  test('Counter value should start at zero', () {
    final counter = Counter();

    expect(counter.value, 0);
  });

  // Test counter counter value that should return to zero after increment and decrement.
  test('Counter value should end at zero', () {
    final counter = Counter();

    counter.decrement();
    counter.decrement();

    counter.increment();

    counter.decrement();
    counter.increment();

    counter.decrement();
    counter.increment();

    counter.increment();

    expect(counter.value, 0);
  });

  test('Counter value should end at zero', () {
    final counter = Counter();

    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.decrement();
    counter.increment();
    counter.increment();
    counter.decrement();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.increment();

    expect(counter.value, 0);
  });

  test('Counter value should end at zero', () {
    final counter = Counter();

    counter.decrement();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.increment();

    expect(counter.value, 0);
  });
  // Test cases for Counter value that should handle mixed operations.
  test('Counter value should end at 1', () {
    final counter = Counter();

    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.increment();

    expect(counter.value, 1);
  });
  test('Counter value should end at 2', () {
    final counter = Counter();

    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.increment();

    expect(counter.value, 2);
  });
  test('Counter value should end at 7', () {
    final counter = Counter();

    counter.increment();
    counter.decrement();
    counter.increment();
    counter.increment();
    counter.increment();
    counter.increment();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.increment();
    counter.increment();
    counter.decrement();
    counter.decrement();
    counter.increment();
    counter.decrement();
    counter.increment();
    counter.increment();

    expect(counter.value, 7);
  });
}
