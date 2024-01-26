import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_health.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/irr_calculator.dart';
import 'package:wealth_wave/utils/utils.dart';

class Goal {
  final int id;
  final String name;
  final String? description;
  final double amount;
  final DateTime amountUpdatedOn;
  final DateTime maturityDate;
  final double inflation;
  final GoalImportance importance;
  final Map<Investment, double> taggedInvestments;

  Goal._(
      {required this.id,
      required this.name,
      required this.description,
      required this.amount,
      required this.maturityDate,
      required this.inflation,
      required this.amountUpdatedOn,
      required this.importance,
      required this.taggedInvestments});

  double get investedAmount => taggedInvestments.entries
      .map((taggedInvestment) => calculatePercentageOfValue(
          value:
              taggedInvestment.key.getTotalInvestedAmount(till: maturityDate),
          percentage: taggedInvestment.value))
      .toList()
      .fold(0.0, (value, element) => value + element);

  double get maturityAmount => IRRCalculator().calculateValueOnIRR(
      irr: inflation,
      futureDate: maturityDate,
      currentValue: amount,
      currentValueUpdatedOn: amountUpdatedOn);

  double get yearsLeft =>
      (maturityDate.difference(DateTime.now()).inDays / 365);

  double get value => taggedInvestments.entries
      .map((taggedInvestment) => calculatePercentageOfValue(
          value: taggedInvestment.key
              .getValueOn(date: DateTime.now(), considerFuturePayments: false),
          percentage: taggedInvestment.value))
      .toList()
      .fold(0.0, (value, element) => value + element);

  double get valueOnMaturity => taggedInvestments.entries
      .map((taggedInvestment) => calculatePercentageOfValue(
          value: taggedInvestment.key
              .getValueOn(date: maturityDate, considerFuturePayments: true),
          percentage: taggedInvestment.value))
      .toList()
      .fold(0.0, (value, element) => value + element);

  double get irr => taggedInvestments.entries
      .map((taggedInvestment) => calculatePercentageOfValue(
          value: taggedInvestment.key.getIRR(),
          percentage: taggedInvestment.value))
      .toList()
      .fold(0.0, (value, element) => value + element);

  Map<RiskLevel, double> get riskComposition => taggedInvestments.entries
          .fold<Map<RiskLevel, double>>({}, (acc, element) {
        Investment investment = element.key;
        double percentage = element.value;
        double value = calculatePercentageOfValue(
            value: investment.getValueOn(
                date: maturityDate, considerFuturePayments: true),
            percentage: percentage);

        return {
          ...acc,
          investment.riskLevel: (acc[investment.riskLevel] ?? 0) + value
        }.map((key, value) => MapEntry(key, value / valueOnMaturity));
      });

  GoalHealth get health {
    Map<RiskLevel, double> riskComposition = this.riskComposition;

    if (importance == GoalImportance.high) {
      if ((riskComposition[RiskLevel.high] ?? 0) > yearsLeft / 2 / 100) {
        return GoalHealth.risky;
      }
      if (riskComposition.containsKey(RiskLevel.medium) &&
          riskComposition[RiskLevel.medium]! > yearsLeft / 3 / 100) {
        return GoalHealth.risky;
      }
    } else if (importance == GoalImportance.medium) {
      if ((riskComposition[RiskLevel.high] ?? 0.0) > yearsLeft / 1.5 / 100) {
        return GoalHealth.risky;
      }
      if (riskComposition.containsKey(RiskLevel.medium) &&
          riskComposition[RiskLevel.medium]! > yearsLeft / 2 / 100) {
        return GoalHealth.risky;
      }
    } else if (importance == GoalImportance.low) {
      if ((riskComposition[RiskLevel.high] ?? 0) > yearsLeft / 1.5 / 100) {
        return GoalHealth.risky;
      }
      if ((riskComposition[RiskLevel.medium] ?? 0) > yearsLeft / 1.5 / 100) {
        return GoalHealth.risky;
      }
    }

    return GoalHealth.good;
  }

  factory Goal.from(
          {required final GoalDO goalDO,
          required final Map<Investment, double> taggedInvestments}) =>
      Goal._(
        id: goalDO.id,
        name: goalDO.name,
        description: goalDO.description,
        amount: goalDO.amount,
        maturityDate: goalDO.maturityDate,
        inflation: goalDO.inflation,
        amountUpdatedOn: goalDO.amountUpdatedOn,
        importance: goalDO.importance,
        taggedInvestments: taggedInvestments,
      );
}
