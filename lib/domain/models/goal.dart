import 'dart:math';

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

  double getInvestedValue() {
    return taggedInvestments.keys
        .map((e) => e.value * (taggedInvestments[e] ?? 0))
        .reduce((a, b) => a + b);
  }

  double getProjectedValue() {
    double years = DateTime.now().difference(targetDate).inDays / 365;
    double growthRate = getIrr();
    double investedValue = getInvestedValue();

    return investedValue * pow(1 + growthRate, years);
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
