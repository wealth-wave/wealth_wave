import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class Goal {
  final int id;
  final String name;
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
      required this.amount,
      required this.createdDate,
      required this.inflation,
      required this.targetAmount,
      required this.targetDate,
      required this.importance,
      required this.taggedInvestments});

  double getIrr() {
    double totalValue = 0.0;
    double weightedSum = 0.0;

    for (var investment in taggedInvestments.keys) {
      double share = taggedInvestments[investment] ?? 0;
      double investedAmount = investment.value * share;
      double growthRate = investment.getIrr() ?? 0;

      totalValue += investedAmount;
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
    return taggedInvestments.keys
        .map((e) => (e.value / 100) * (taggedInvestments[e] ?? 0))
        .reduce((a, b) => a + b);
  }

  double getProgress() {
    return getInvestedValue() / targetAmount;
  }

  double getYearsLeft() {
    return targetDate.difference(DateTime.now()).inDays.toDouble() / 365;
  }

  static Goal from(
          {required final GoalDO goal,
          required final Map<Investment, double> taggedInvestments}) =>
      Goal(
          id: goal.id,
          name: goal.name,
          amount: goal.amount,
          createdDate: goal.date,
          inflation: goal.inflation,
          targetAmount: goal.targetAmount,
          targetDate: goal.targetDate,
          importance: goal.importance,
          taggedInvestments: taggedInvestments);
}
