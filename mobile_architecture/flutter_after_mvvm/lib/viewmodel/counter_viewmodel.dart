import 'package:flutter/material.dart';
import '../model/counter_model.dart';

class CounterViewModel extends ChangeNotifier {
  CounterModel _counter = CounterModel(value: 0);
  bool _loading = true;

  CounterModel get counter => _counter;
  bool get isLoading => _loading;

  CounterViewModel() {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.delayed(Duration(seconds: 1));
    _counter = CounterModel(value: 5);
    _loading = false;
    notifyListeners();
  }

  void increment() {
    _counter.value++;
    notifyListeners();
  }

  void decrement() {
    _counter.value--;
    notifyListeners();
  }
}
