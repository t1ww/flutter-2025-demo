import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/expense_viewmodel.dart';
import '../model/transaction.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ExpenseViewModel>(context);
    return Column(
      children: [
        Text('Balance: ${vm.balance.toStringAsFixed(2)}'),
        Text('Income: ${vm.totalIncome.toStringAsFixed(2)}'),
        Text('Expense: ${vm.totalExpense.toStringAsFixed(2)}'),
        Expanded(
          child: ListView.builder(
            itemCount: vm.transactions.length,
            itemBuilder: (context, index) {
              final t = vm.transactions[index];
              return ListTile(
                title: Text(t.category),
                subtitle: Text('${t.amount} - ${t.type.name}'),
                trailing: Text('${t.date.toLocal()}'.split(' ')[0]),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          child: const Text('Add Transaction'),
        ),
      ],
    );
  }
}
