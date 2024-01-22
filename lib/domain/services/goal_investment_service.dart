import 'package:wealth_wave/api/apis/goal_investment_api.dart';
import 'package:wealth_wave/domain/models/goal_investment_tag.dart';

class GoalInvestmentService {
  final GoalInvestmentApi _goalInvestmentApi;

  factory GoalInvestmentService() {
    return _instance;
  }

  static final GoalInvestmentService _instance = GoalInvestmentService._();

  GoalInvestmentService._({final GoalInvestmentApi? goalInvestmentApi})
      : _goalInvestmentApi = goalInvestmentApi ?? GoalInvestmentApi();

  Future<void> tagGoalInvestment(
      {required final int goalId,
      required final int investmentId,
      required final double split}) async {
    return _goalInvestmentApi
        .create(
            goalId: goalId, investmentId: investmentId, splitPercentage: split)
        .then((goalInvestmentDO) => {});
  }

  Future<void> updateTaggedGoalInvestment(
      {required final int id,
      required final int goalId,
      required final int investmentId,
      required final double split}) async {
    return _goalInvestmentApi
        .update(
            id: id,
            goalId: goalId,
            investmentId: investmentId,
            splitPercentage: split)
        .then((goalInvestmentDO) => {});
  }

  Future<GoalInvestmentTag> getById({required final int id}) async {
    return _goalInvestmentApi.getById(id: id).then((goalInvestmentDO) {
      return GoalInvestmentTag.from(goalInvestmentDO: goalInvestmentDO);
    });
  }

  Future<List<GoalInvestmentTag>> getBy(
      {final int? investmentId, final int? goalId}) async {
    return _goalInvestmentApi
        .getBy(investmentId: investmentId, goalId: goalId)
        .then((goalInvestments) => Future.wait(goalInvestments.map(
            (goalInvestment) =>
                GoalInvestmentTag.from(goalInvestmentDO: goalInvestment))));
  }

  Future<void> deleteTaggedGoal({required final int id}) {
    return _goalInvestmentApi.deleteBy(id: id).then((count) => {});
  }
}
