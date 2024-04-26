import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/api/apis/goal_investment_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/apis/script_api.dart';
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
  final ScriptApi _scriptApi;

  factory GoalService() {
    return _instance;
  }

  static final GoalService _instance = GoalService._();

  GoalService._(
      {GoalApi? goalApi,
      GoalInvestmentApi? goalInvestmentApi,
      InvestmentApi? investmentApi,
      TransactionApi? transactionApi,
      SipApi? sipApi,
      ScriptApi? scriptApi})
      : _goalApi = goalApi ?? GoalApi(),
        _goalInvestmentApi = goalInvestmentApi ?? GoalInvestmentApi(),
        _investmentApi = investmentApi ?? InvestmentApi(),
        _transactionAPi = transactionApi ?? TransactionApi(),
        _sipApi = sipApi ?? SipApi(),
        _scriptApi = scriptApi ?? ScriptApi();

  Future<void> create({
    required final String name,
    required final String? description,
    required final double amount,
    required final DateTime amountUpdatedOn,
    required final DateTime maturityDate,
    required final double inflation,
    required final GoalImportance importance,
  }) =>
      _goalApi
          .create(
              name: name,
              description: description,
              amount: amount,
              amountUpdatedOn: amountUpdatedOn,
              maturityDate: maturityDate,
              inflation: inflation,
              importance: importance)
          .then((_) => {});

  Future<List<Goal>> get() async {
    List<InvestmentDO> investmentDOs = await _investmentApi.getAll();
    List<ScriptDO> scriptDOs = await _scriptApi.getAll();
    List<GoalDO> goalDOs = await _goalApi.get();
    List<Goal> goals = List.empty(growable: true);
    for (final goalDO in goalDOs) {
      List<GoalInvestmentDO> goalInvestments =
          await _goalInvestmentApi.getBy(goalId: goalDO.id);
      Map<Investment, double> taggedInvestment = {};
      for (final goalInvestment in goalInvestments) {
        InvestmentDO investmentEnrichedDO = investmentDOs
            .where((element) => element.id == goalInvestment.investmentId)
            .first;
        List<TransactionDO> transactionsDOs =
            await _transactionAPi.getBy(investmentId: investmentEnrichedDO.id);
        List<SipDO> sipDOs =
            await _sipApi.getBy(investmentId: investmentEnrichedDO.id);
        Investment investment = Investment.from(
            investmentDO: investmentEnrichedDO,
            transactionsDOs: transactionsDOs,
            scriptDO: scriptDOs
                .where((element) =>
                    element.investmentId == investmentEnrichedDO.id)
                .firstOrNull,
            sipDOs: sipDOs);
        taggedInvestment[investment] = goalInvestment.splitPercentage;
      }
      goals.add(Goal.from(goalDO: goalDO, taggedInvestments: taggedInvestment));
    }

    return goals;
  }

  Future<Goal> getBy({required final int id}) async {
    List<InvestmentDO> investmentDOs = await _investmentApi.getAll();
    List<ScriptDO> scriptDOs = await _scriptApi.getAll();
    GoalDO goalDO = await _goalApi.getBy(id: id);
    List<GoalInvestmentDO> goalInvestments =
        await _goalInvestmentApi.getBy(goalId: goalDO.id);
    Map<Investment, double> taggedInvestment = {};
    for (final goalInvestment in goalInvestments) {
      InvestmentDO investmentEnrichedDO = investmentDOs
          .where((element) => element.id == goalInvestment.investmentId)
          .first;
      List<TransactionDO> transactionsDOs =
          await _transactionAPi.getBy(investmentId: investmentEnrichedDO.id);
      List<SipDO> sipDOs =
          await _sipApi.getBy(investmentId: investmentEnrichedDO.id);
      Investment investment = Investment.from(
          scriptDO: scriptDOs
              .where(
                  (element) => element.investmentId == investmentEnrichedDO.id)
              .firstOrNull,
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
  }) =>
      _goalApi
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

  Future<void> deleteBy({required final int id}) => _goalApi.deleteBy(id: id);
}
