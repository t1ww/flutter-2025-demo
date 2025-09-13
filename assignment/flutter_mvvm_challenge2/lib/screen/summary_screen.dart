import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/expense_viewmodel.dart';

class SummaryScreen extends StatelessWidget {
  final DateTime month;
  const SummaryScreen({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ExpenseViewModel>(context);
    final summary = vm.getMonthlySummary(month);
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Summary')),
      body: ListView(
        children:
            summary.entries
                .map(
                  (e) => ListTile(
                    title: Text(e.key),
                    trailing: Text(e.value.toStringAsFixed(2)),
                  ),
                )
                .toList(),
      ),
    );
  }
}
