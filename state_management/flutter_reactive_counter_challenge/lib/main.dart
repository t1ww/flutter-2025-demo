// state_management\flutter_reactive_counter_challenge\lib\main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ItemListModel(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CounterScreen());
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reactive Items')),
      body: Consumer<ItemListModel>(
        builder: (context, itemList, child) {
          return ListView.builder(
            itemCount: itemList.items.length,
            itemBuilder: (context, index) {
              final item = itemList.items[index];
              return ListTile(
                title: Text('Item ${item.number}'),
                trailing: IconButton(
                  icon: Icon(
                    item.heart ? Icons.favorite : Icons.favorite_border,
                    color: item.heart ? Colors.red : null,
                  ),
                  onPressed: () => itemList.toggleHeart(index),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ItemListModel>().resetHearts(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
