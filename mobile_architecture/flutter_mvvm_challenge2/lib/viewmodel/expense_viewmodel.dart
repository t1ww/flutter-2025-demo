import 'package:flutter/material.dart';
import '../model/transaction.dart';

class ExpenseViewModel extends ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => List.unmodifiable(_transactions);

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  double get totalIncome => _transactions
      .where((t) => t.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpense => _transactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get balance => totalIncome - totalExpense;

  List<Transaction> filterByCategory(String category) {
    return _transactions.where((t) => t.category == category).toList();
  }

  List<Transaction> filterByMonth(DateTime month) {
    return _transactions
        .where((t) => t.date.year == month.year && t.date.month == month.month)
        .toList();
  }

  Map<String, double> getMonthlySummary(DateTime month) {
    final summary = <String, double>{};
    for (var t in filterByMonth(month)) {
      summary[t.category] = (summary[t.category] ?? 0) + t.amount;
    }
    return summary;
  }
}
