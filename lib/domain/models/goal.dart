import 'package:wealth_wave/api/apis/goal_investment_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
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
                    MapEntry(investment, goalInvestment.splitPercentage)))))
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
                .then((amount) => calculatePercentageOfValue(
                    value: amount,
                    percentage: goalInvestment.splitPercentage)))))
        .then((amounts) => amounts.isNotEmpty
            ? amounts.reduce((value, element) => value + element)
            : 0);
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
                .then((amount) => calculatePercentageOfValue(
                    value: amount,
                    percentage: goalInvestment.splitPercentage)))))
        .then((amounts) => amounts.isNotEmpty
            ? amounts.reduce((value, element) => value + element)
            : 0);
  }

  Future<void> tagInvestment(
      {required final int investmentId, required final double split}) async {
    return _goalInvestmentApi
        .create(goalId: id, investmentId: investmentId, splitPercentage: split)
        .then((goalInvestmentDO) => {});
  }

  Future<void> updateTaggedInvestment(
      {required final int id,
      required final int investmentId,
      required final double split}) async {
    return _goalInvestmentApi
        .update(
            id: id,
            goalId: id,
            investmentId: investmentId,
            splitPercentage: split)
        .then((goalInvestmentDO) => {});
  }

  Future<void> deleteTaggedInvestment({required final int investmentId}) {
    return _goalInvestmentApi
        .deleteBy(goalId: id, investmentId: investmentId)
        .then((count) => {});
  }

  Future<double> getIRR() async {
    var goalInvestments = await _goalInvestmentApi.getBy(goalId: id);
    var investmentData = [];

    for (var goalInvestment in goalInvestments) {
      var investmentDO = await _investmentApi.getById(id: goalInvestment.investmentId);
      var investment = Investment.from(investmentDO: investmentDO);
      var value = investment.value;
      var irr = await investment.getIRR();

      investmentData.add({
        'value': value,
        'irr': irr,
      });
    }

    var totalValue = investmentData.fold(0.0, (sum, investment) => sum + investment['value']!);
    var weightedIRRSum = investmentData.fold(
        0.0,
        (sum, investment) =>
            sum +
            calculatePercentageOfValue(
                value: investment['value']!, percentage: investment['irr']!));

    return totalValue == 0 ? 0 : weightedIRRSum / totalValue;
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
