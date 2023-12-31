import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class Goal {
  final int id;
  final String name;
  final String? description;
  final double amount;
  final DateTime createdDate;
  final double inflation;
  final double targetAmount;
  final DateTime targetDate;
  final GoalImportance importance;
  final Map<Investment, double> taggedInvestments;

  Goal(
      {required this.id,
      required this.name,
      required this.description,
      required this.amount,
      required this.createdDate,
      required this.inflation,
      required this.targetAmount,
      required this.targetDate,
      required this.importance,
      required this.taggedInvestments});

  double getIrr({bool considerFutureTransactions = false}) {
    double totalValue = 0.0;
    double weightedSum = 0.0;

    for (var investment in taggedInvestments.keys) {
      totalValue += investment.getFutureValueOn(date);
      weightedSum += investedAmount * growthRate;
    }

    if (totalValue == 0.0) {
      return 0.0;
    }

    return weightedSum / totalValue;
  }

  double getInvestedAmount() {
    return taggedInvestments.keys
        .map((e) => e.totalInvestedAmount * (taggedInvestments[e] ?? 0))
        .reduce((a, b) => a + b);
  }

  double getInvestedValue() {
    if (taggedInvestments.isEmpty) {
      return 0;
    }
    return taggedInvestments.keys
        .map((e) => (e.value / 100) * (taggedInvestments[e] ?? 0))
        .reduce((a, b) => a + b);
  }

  double getProgress() {
    double progress =
        targetAmount > 0 ? getFutureValueOnTargetDate() / targetAmount : 0;
    if (progress > 1) {
      return 1;
    }
    return progress;
  }

  double getYearsLeft() {
    return targetDate.difference(DateTime.now()).inDays.toDouble() / 365;
  }

  double getFutureValueOnTargetDate() {
    if (taggedInvestments.isEmpty) {
      return 0;
    }
    return taggedInvestments.entries
        .map((e) => e.key.getFutureValueOn(targetDate) * e.value / 100)
        .reduce((a, b) => a + b);
  }

  static Goal from(
          {required final GoalDO goal,
          required final Map<Investment, double> taggedInvestments}) =>
      Goal(
          id: goal.id,
          name: goal.name,
          description: goal.description,
          amount: goal.amount,
          createdDate: goal.date,
          inflation: goal.inflation,
          targetAmount: goal.targetAmount,
          targetDate: goal.targetDate,
          importance: goal.importance,
          taggedInvestments: taggedInvestments);
}
