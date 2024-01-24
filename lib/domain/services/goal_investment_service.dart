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
      _goalInvestmentApi.getById(id: id).then((goalInvestmentDO) =>
          GoalInvestmentTag.from(goalInvestmentDO: goalInvestmentDO));

  Future<List<GoalInvestmentTag>> getBy(
          {final int? investmentId, final int? goalId}) =>
      _goalInvestmentApi.getBy(investmentId: investmentId, goalId: goalId).then(
          (goalInvestments) => goalInvestments
              .map((goalInvestment) =>
                  GoalInvestmentTag.from(goalInvestmentDO: goalInvestment))
              .toList());

  Future<void> deleteTaggedGoal({required final int id}) =>
      _goalInvestmentApi.deleteBy(id: id).then((count) => {});
}
