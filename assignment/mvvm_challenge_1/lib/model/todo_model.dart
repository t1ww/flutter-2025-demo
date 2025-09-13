import 'package:flutter/material.dart';

class TodoModel extends ChangeNotifier {
  String todoString = '';
  bool checked = false;

  TodoModel({required this.todoString, required this.checked});
}
