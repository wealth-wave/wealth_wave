import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/irr_calculator.dart';
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
