
import 'package:flutter/material.dart';
import 'counter_repository.dart';

class CounterViewModel extends ChangeNotifier {
  final CounterRepository repository;

  CounterViewModel(this.repository);

  int get counter => repository.getCounter();

  void incrementCounter() {
    repository.increment();
    notifyListeners();
  }

  void resetCounter() {
    repository.reset();
    notifyListeners();
  }
}
