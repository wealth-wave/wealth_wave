import 'package:wealth_wave/api/apis/goal_investment_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/domain/models/investment.dart';

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
      final InvestmentApi? investmentApi})
      : _goalInvestmentApi = goalInvestmentApi ?? GoalInvestmentApi(),
        _investmentApi = investmentApi ?? InvestmentApi();

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
