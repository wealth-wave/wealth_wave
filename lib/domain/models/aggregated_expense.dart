import 'package:wealth_wave/api/db/app_database.dart';

class AggregatedExpense {
  final double amount;
  final List<String> tags;
  final DateTime createdMonthDate;

  AggregatedExpense._({
    required this.amount,
    required this.createdMonthDate,
    required this.tags,
  });

  factory AggregatedExpense.from({required AggregatedExpenseDO expenseDO}) =>
      AggregatedExpense._(
          amount: expenseDO.amount,
          createdMonthDate: expenseDO.createdMonthDate,
          tags: expenseDO.tags.split(','));
}
