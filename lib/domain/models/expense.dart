import 'package:wealth_wave/api/db/app_database.dart';

class Expense {
  final double amount;
  final String? description;
  final List<String> tags;
  final DateTime createdOn;

  Expense._({
    required this.amount,
    required this.createdOn,
    required this.description,
    required this.tags,
  });

  factory Expense.from({required ExpenseDO expenseDO}) => Expense._(
      amount: expenseDO.amount,
      createdOn: expenseDO.createdOn,
      description: expenseDO.description,
      tags: expenseDO.tags.split(','));
}
