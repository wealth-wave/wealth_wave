import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/models/goal_health_evaluator.dart';
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
      .map((taggedInvestment) {
        return calculatePercentageOfValue(
          value: taggedInvestment.key.getValueOn(date: DateTime.now()),
          percentage: taggedInvestment.value);
      })
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

  Map<RiskLevel, double> get riskComposition {
    double valueOnMaturity = this.valueOnMaturity;
    return taggedInvestments.entries.fold({}, (acc, element) {
      Investment investment = element.key;
      double percentage = element.value;
      double value = calculatePercentageOfValue(
          value: investment.getValueOn(
              date: maturityDate, considerFuturePayments: true),
          percentage: percentage);

      return {
        ...acc,
        investment.riskLevel: (acc[investment.riskLevel] ?? 0) + value
      };
    }).map((key, value) => MapEntry(key, value / valueOnMaturity));
  }

  Map<String, double> get basketComposition {
    double valueOnMaturity = this.valueOnMaturity;
    return taggedInvestments.entries.fold({}, (acc, element) {
      Investment investment = element.key;
      double percentage = element.value;
      double value = calculatePercentageOfValue(
          value: investment.getValueOn(
              date: maturityDate, considerFuturePayments: true),
          percentage: percentage);

      return {
        ...acc,
        investment.basketName: (acc[investment.basketName] ?? 0) + value
      };
    }).map((key, value) => MapEntry(key, value / valueOnMaturity));
  }

  List<String> get healthSuggestions {
    return GoalHealthEvaluator().evaluate(this);
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
