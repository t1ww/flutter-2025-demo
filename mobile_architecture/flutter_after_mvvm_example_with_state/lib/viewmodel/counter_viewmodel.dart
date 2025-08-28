import 'package:flutter/material.dart';
import '../model/counter_model.dart';

class CounterState {
  final CounterModel counter;
  final bool isLoading;

  CounterState({required this.counter, required this.isLoading});
}

class CounterViewModel extends ChangeNotifier {
  CounterState _state = CounterState(counter: CounterModel(value: 0), isLoading: true);

  CounterState get state => _state;

  CounterViewModel() {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.delayed(Duration(seconds: 1));
    _state = CounterState(counter: CounterModel(value: 5), isLoading: false);
    notifyListeners();
  }

  void increment() {
    _state.counter.value++;
    notifyListeners();
  }

  void decrement() {
    _state.counter.value--;
    notifyListeners();
  }
}
