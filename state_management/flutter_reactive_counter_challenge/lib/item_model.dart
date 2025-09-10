// state_management\flutter_reactive_counter_challenge\lib\item_model.dart
import 'package:flutter/material.dart';

class ItemModel {
  final int number;
  bool heart = false;

  ItemModel(this.number);
}

class ItemListModel extends ChangeNotifier {
  final List<ItemModel> items = List.generate(
    10,
    (index) => ItemModel(index + 1),
  );

  void toggleHeart(int index) {
    items[index].heart = !items[index].heart;
    notifyListeners(); // rebuilds widgets listening to the model
  }

  void resetHearts() {
    for (var item in items) {
      item.heart = false;
    }
    notifyListeners();
  }
}
