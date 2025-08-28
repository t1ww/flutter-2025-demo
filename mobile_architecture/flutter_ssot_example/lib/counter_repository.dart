
class CounterRepository {
  int _counter = 0;

  int getCounter() => _counter;

  void increment() {
    _counter++;
  }

  void reset() {
    _counter = 0;
  }
}
