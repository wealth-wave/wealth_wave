import 'package:wealth_wave/domain/models/expense.dart';

class ExpenseVO {
  final int id;
  final double amount;
  final String? description;
  final DateTime createdOn;
  final List<String> tags;

  ExpenseVO._(
      {required this.id,
      required this.description,
      required this.amount,
      required this.createdOn,
      required this.tags});

  factory ExpenseVO.from({required final Expense expense}) {
    return ExpenseVO._(
        id: expense.id,
        description: expense.description,
        amount: expense.amount,
        createdOn: expense.createdOn,
        tags: expense.tags);
  }
}
