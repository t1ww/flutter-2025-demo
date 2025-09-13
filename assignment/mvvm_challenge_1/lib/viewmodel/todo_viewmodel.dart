import 'package:flutter/material.dart';
import '../model/todo_model.dart';

class TodoState {
  final TodoModel todo;
  final bool isLoading;

  TodoState({required this.todo, required this.isLoading});
}

class TodoViewModel extends ChangeNotifier {
  List<TodoModel> _todos = [];
  bool _isLoading = true;

  List<TodoModel> get todos => _todos;
  bool get isLoading => _isLoading;

  TodoViewModel(List<String> initialTodos) {
    _todos = initialTodos
        .map((t) => TodoModel(todoString: t, checked: false))
        .toList();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.delayed(const Duration(seconds: 1));
    _isLoading = false;
    notifyListeners();
  }

  void toggleChecked(int index) {
    _todos[index].checked = !_todos[index].checked;
    notifyListeners();
  }

  void add(String text) {
    _todos.add(TodoModel(todoString: text, checked: false));
    notifyListeners();
  }

  void remove(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
