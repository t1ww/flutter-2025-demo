import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/expense_viewmodel.dart';
import '../model/transaction.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _category = '';
  double _amount = 0.0;
  TransactionType _type = TransactionType.expense;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category'),
                onSaved: (val) => _category = val ?? '',
                validator:
                    (val) =>
                        val == null || val.isEmpty ? 'Enter category' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (val) {
                  _amount = double.tryParse(val ?? '') ?? 0.0;
                },
                validator:
                    (val) =>
                        val == null || double.tryParse(val) == null
                            ? 'Enter valid amount'
                            : null,
              ),
              DropdownButtonFormField<TransactionType>(
                value: _type,
                items:
                    TransactionType.values
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(type.name),
                          ),
                        )
                        .toList(),
                onChanged:
                    (val) =>
                        setState(() => _type = val ?? TransactionType.expense),
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Provider.of<ExpenseViewModel>(
                      context,
                      listen: false,
                    ).addTransaction(
                      Transaction(
                        category: _category,
                        amount: _amount,
                        date: _date,
                        type: _type,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
