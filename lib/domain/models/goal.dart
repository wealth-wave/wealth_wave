import 'dart:ffi';

import 'package:wealth_wave/api/apis/goal_investment_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/irr_calculator.dart';

class Goal {
  final int id;
  final String name;
  final String? description;
  final double amount;
  final DateTime amountUpdatedOn;
  final DateTime maturityDate;
  final double inflation;
  final GoalImportance importance;

  final GoalInvestmentApi _goalInvestmentApi;
  final InvestmentApi _investmentApi;
  final IRRCalculator _irrCalculator;

  Goal(
      {required this.id,
      required this.name,
      required this.description,
      required this.amount,
      required this.maturityDate,
      required this.inflation,
      required this.amountUpdatedOn,
      required this.importance,
      final GoalInvestmentApi? goalInvestmentApi,
      final InvestmentApi? investmentApi,
      final IRRCalculator? irrCalculator})
      : _goalInvestmentApi = goalInvestmentApi ?? GoalInvestmentApi(),
        _investmentApi = investmentApi ?? InvestmentApi(),
        _irrCalculator = irrCalculator ?? IRRCalculator();

  Future<Map<Investment, double>> getInvestments() async {
    return _goalInvestmentApi
        .getBy(goalId: id)
        .then((goalInvestments) => Future.wait(goalInvestments.map(
            (goalInvestment) => _investmentApi
                .getById(id: goalInvestment.investmentId)
                .then((investmentDO) =>
                    Investment.from(investmentDO: investmentDO))
                .then((investment) =>
                    MapEntry(investment, goalInvestment.split)))))
        .then((entries) => Map.fromEntries(entries));
  }

  Future<double> getInvestedAmount() async {
    return _goalInvestmentApi
        .getBy(goalId: id)
        .then((goalInvestments) => Future.wait(goalInvestments.map(
            (goalInvestment) => _investmentApi
                .getById(id: goalInvestment.investmentId)
                .then((investmentDO) =>
                    Investment.from(investmentDO: investmentDO))
                .then((investment) => investment.getTotalInvestedAmount())
                .then((amount) => amount * goalInvestment.split))))
        .then((amounts) => amounts.reduce((value, element) => value + element));
  }

  Future<double> getMaturityAmount() {
    return Future(() => _irrCalculator.calculateValueOnIRR(
        irr: inflation,
        date: maturityDate,
        value: amount,
        valueUpdatedOn: amountUpdatedOn));
  }

  Future<double> getValueOnMaturity() async {
    return _goalInvestmentApi
        .getBy(goalId: id)
        .then((goalInvestments) => Future.wait(goalInvestments.map(
            (goalInvestment) => _investmentApi
                .getById(id: goalInvestment.investmentId)
                .then((investmentDO) =>
                    Investment.from(investmentDO: investmentDO))
                .then((investment) => investment.getValueOn(
                    date: maturityDate, considerFuturePayments: true))
                .then((amount) => amount * goalInvestment.split))))
        .then((amounts) => amounts.reduce((value, element) => value + element));
  }

  Future<MapEntry<Investment, double>> tagInvestment(
      {required final Investment investment,
      required final double split}) async {
    return _goalInvestmentApi
        .create(goalId: id, investmentId: investment.id, split: split)
        .then((goalInvestmentDO) => MapEntry(investment, split));
  }

  Future<MapEntry<Investment, double>> updateTaggedInvestment(
      {required final Investment investment,
      required final double split}) async {
    return _goalInvestmentApi
        .update(goalId: id, investmentId: investment.id, split: split)
        .then((goalInvestmentDO) => MapEntry(investment, split));
  }

  Future<void> deleteTaggedInvestment({required final Investment investment}) {
    return _goalInvestmentApi
        .deleteBy(goalId: id, investmentId: investment.id)
        .then((count) => Void);
  }

  Future<double> getIRR() async {
    return _goalInvestmentApi
        .getBy(goalId: id)
        .then((goalInvestments) => Future.wait(goalInvestments.map(
            (goalInvestment) => _investmentApi
                .getById(id: goalInvestment.investmentId)
                .then((investmentDO) =>
                    Investment.from(investmentDO: investmentDO))
                .then((investment) async => {
                      'value': investment.value,
                      'irr': await investment.getIRR(),
                    }))))
        .then((investmentData) {
      var totalValue = investmentData.fold(
          0.0, (sum, investment) => sum + investment['value']!);
      var weightedIRRSum = investmentData.fold(0.0,
          (sum, investment) => sum + investment['value']! * investment['irr']!);
      return weightedIRRSum / totalValue;
    });
  }

  static Goal from({required final GoalDO goalDO}) {
    return Goal(
        id: goalDO.id,
        name: goalDO.name,
        description: goalDO.description,
        amount: goalDO.amount,
        maturityDate: goalDO.maturityDate,
        inflation: goalDO.inflation,
        amountUpdatedOn: goalDO.amountUpdatedOn,
        importance: goalDO.importance);
  }
}
