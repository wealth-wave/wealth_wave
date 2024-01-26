import 'package:wealth_wave/api/apis/goal_investment_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/goal_investment_tag.dart';

class GoalInvestmentService {
  final GoalInvestmentApi _goalInvestmentApi;
  final InvestmentApi _investmentApi;
  final TransactionApi _transactionApi;
  final SipApi _sipApi;

  factory GoalInvestmentService() {
    return _instance;
  }

  static final GoalInvestmentService _instance = GoalInvestmentService._();

  GoalInvestmentService._(
      {final GoalInvestmentApi? goalInvestmentApi,
      final InvestmentApi? investmentApi,
      final TransactionApi? transactionApi,
      final SipApi? sipApi})
      : _goalInvestmentApi = goalInvestmentApi ?? GoalInvestmentApi(),
        _investmentApi = investmentApi ?? InvestmentApi(),
        _transactionApi = transactionApi ?? TransactionApi(),
        _sipApi = sipApi ?? SipApi();

  Future<void> tagGoalInvestment(
          {required final int goalId,
          required final int investmentId,
          required final double split}) =>
      _goalInvestmentApi
          .create(
              goalId: goalId,
              investmentId: investmentId,
              splitPercentage: split)
          .then((goalInvestmentDO) => {});

  Future<void> updateTaggedGoalInvestment(
          {required final int id,
          required final int goalId,
          required final int investmentId,
          required final double split}) =>
      _goalInvestmentApi
          .update(
              id: id,
              goalId: goalId,
              investmentId: investmentId,
              splitPercentage: split)
          .then((goalInvestmentDO) => {});

  Future<GoalInvestmentTag> getById({required final int id}) =>
      _goalInvestmentApi.getById(id: id).then((goalInvestmentDO) async {
        final InvestmentDO investmentDO =
            await _investmentApi.getById(id: goalInvestmentDO.investmentId);
        final transactionDOs = await _transactionApi.getBy(
            investmentId: goalInvestmentDO.investmentId);
        final sipDOs =
            await _sipApi.getBy(investmentId: goalInvestmentDO.investmentId);
        return GoalInvestmentTag.from(
            investmentDOs: [investmentDO],
            goalInvestmentDO: goalInvestmentDO,
            transactionsDOs: transactionDOs,
            sipDOs: sipDOs);
      });

  Future<List<GoalInvestmentTag>> getBy(
      {final int? investmentId, final int? goalId}) async {
    List<InvestmentDO> investmentDos = await _investmentApi.getAll();
    List<TransactionDO> transactionsDOs = await _transactionApi.getAll();
    List<SipDO> sipDOs = await _sipApi.getAll();

    return _goalInvestmentApi
        .getBy(investmentId: investmentId, goalId: goalId)
        .then((goalInvestments) => goalInvestments
            .map((goalInvestment) => GoalInvestmentTag.from(
                goalInvestmentDO: goalInvestment,
                investmentDOs: investmentDos,
                transactionsDOs: transactionsDOs,
                sipDOs: sipDOs))
            .toList());
  }

  Future<void> deleteTaggedGoal({required final int id}) =>
      _goalInvestmentApi.deleteBy(id: id).then((count) => {});
}
