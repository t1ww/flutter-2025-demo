import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/todo_viewmodel.dart';

class TodoPage extends StatelessWidget {
  final List<String> initialTodos;
  const TodoPage({super.key, required this.initialTodos});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => TodoViewModel(initialTodos),
      child: Scaffold(
        appBar: AppBar(title: const Text('Todo App')),
        body: Consumer<TodoViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            labelText: 'New Todo',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (textController.text.trim().isNotEmpty) {
                            vm.add(textController.text.trim());
                            textController.clear();
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.todos.length,
                    itemBuilder: (context, index) {
                      final todo = vm.todos[index];
                      return Dismissible(
                        key: Key(todo.todoString),
                        onDismissed: (_) => vm.remove(index),
                        background: Container(color: Colors.red),
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: todo.checked,
                          title: Text(todo.todoString),
                          onChanged: (_) => vm.toggleChecked(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
