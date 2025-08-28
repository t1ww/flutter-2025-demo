
import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Notifies listeners to rebuild when state changes
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}
