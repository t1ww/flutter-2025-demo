import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/counter_viewmodel.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Counter App')),
        body: Consumer<CounterViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Text('Counter: ${vm.counter.value}', style: TextStyle(fontSize: 32)),
            );
          },
        ),
        floatingActionButton: Consumer<CounterViewModel>(
          builder: (context, vm, _) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(onPressed: vm.increment, child: Icon(Icons.add)),
              SizedBox(width: 16),
              FloatingActionButton(onPressed: vm.decrement, child: Icon(Icons.remove)),
            ],
          ),
        ),
      ),
    );
  }
}
