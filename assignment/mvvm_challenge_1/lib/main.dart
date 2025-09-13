import 'package:flutter/material.dart';
import 'view/todo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoPage(
        initialTodos: ["Todo first one!", "Do the other thing too!"],
      ),
    );
  }
}
