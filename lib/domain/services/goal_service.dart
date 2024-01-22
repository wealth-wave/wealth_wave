import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/api/apis/goal_investment_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class GoalService {
  final GoalApi _goalApi;
  final GoalInvestmentApi _goalInvestmentApi;
  final InvestmentApi _investmentApi;
  final TransactionApi _transactionAPi;
  final SipApi _sipApi;

  factory GoalService() {
    return _instance;
  }

  static final GoalService _instance = GoalService._();

  GoalService._(
      {GoalApi? goalApi,
      GoalInvestmentApi? goalInvestmentApi,
      InvestmentApi? investmentApi,
      TransactionApi? transactionApi,
      SipApi? sipApi})
      : _goalApi = goalApi ?? GoalApi(),
        _goalInvestmentApi = goalInvestmentApi ?? GoalInvestmentApi(),
        _investmentApi = investmentApi ?? InvestmentApi(),
        _transactionAPi = transactionApi ?? TransactionApi(),
        _sipApi = sipApi ?? SipApi();

  Future<void> create({
    required final String name,
    required final String? description,
    required final double amount,
    required final DateTime amountUpdatedOn,
    required final DateTime maturityDate,
    required final double inflation,
    required final GoalImportance importance,
  }) {
    return _goalApi
        .create(
            name: name,
            description: description,
            amount: amount,
            amountUpdatedOn: amountUpdatedOn,
            maturityDate: maturityDate,
            inflation: inflation,
            importance: importance)
        .then((_) => {});
  }

  Future<List<Goal>> get() async {
    List<InvestmentDO> investmentDOs = await _investmentApi.get();
    List<GoalDO> goalDOs = await _goalApi.get();
    List<Goal> goals = List.empty(growable: true);
    for (final goalDO in goalDOs) {
      List<GoalInvestmentDO> goalInvestments =
          await _goalInvestmentApi.getBy(goalId: goalDO.id);
      Map<Investment, double> taggedInvestment = {};
      for (final goalInvestment in goalInvestments) {
        InvestmentDO investmentEnrichedDO = investmentDOs
            .where((element) => element.id == goalInvestment.id)
            .first;
        List<TransactionDO> transactionsDOs =
            await _transactionAPi.getBy(investmentId: investmentEnrichedDO.id);
        List<SipDO> sipDOs =
            await _sipApi.getBy(investmentId: investmentEnrichedDO.id);
        Investment investment = Investment.from(
            investmentDO: investmentEnrichedDO,
            transactionsDOs: transactionsDOs,
            sipDOs: sipDOs);
        taggedInvestment[investment] = goalInvestment.splitPercentage;
      }
      goals.add(Goal.from(goalDO: goalDO, taggedInvestments: taggedInvestment));
    }

    return goals;
  }

  Future<Goal> getBy({required final int id}) async {
    List<InvestmentDO> investmentDOs = await _investmentApi.get();
    GoalDO goalDO = await _goalApi.getBy(id: id);
    List<GoalInvestmentDO> goalInvestments =
        await _goalInvestmentApi.getBy(goalId: goalDO.id);
    Map<Investment, double> taggedInvestment = {};
    for (final goalInvestment in goalInvestments) {
      InvestmentDO investmentEnrichedDO = investmentDOs
          .where((element) => element.id == goalInvestment.id)
          .first;
      List<TransactionDO> transactionsDOs =
          await _transactionAPi.getBy(investmentId: investmentEnrichedDO.id);
      List<SipDO> sipDOs =
          await _sipApi.getBy(investmentId: investmentEnrichedDO.id);
      Investment investment = Investment.from(
          investmentDO: investmentEnrichedDO,
          transactionsDOs: transactionsDOs,
          sipDOs: sipDOs);
      taggedInvestment[investment] = goalInvestment.splitPercentage;
    }
    return Goal.from(goalDO: goalDO, taggedInvestments: taggedInvestment);
  }

  Future<void> update({
    required final int id,
    required final String name,
    required final String? description,
    required final double amount,
    required final DateTime amountUpdatedOn,
    required final DateTime maturityDate,
    required final double inflation,
    required final GoalImportance importance,
  }) {
    return _goalApi
        .update(
            id: id,
            name: name,
            description: description,
            amount: amount,
            amountUpdatedOn: amountUpdatedOn,
            maturityDate: maturityDate,
            inflation: inflation,
            importance: importance)
        .then((_) => {});
  }

  Future<void> deleteBy({required final int id}) {
    return _goalApi.deleteBy(id: id);
  }
}
