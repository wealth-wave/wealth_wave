import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/usecases/fetch_investments_use_case.dart';

class FetchGoalsUseCase {
  final GoalApi _goalApi;
  final FetchInvestmentsUseCase _fetchInvestmentsUseCase;

  FetchGoalsUseCase(
      {GoalApi? goalApi, FetchInvestmentsUseCase? fetchInvestmentsUseCase})
      : _goalApi = goalApi ?? GoalApi(),
        _fetchInvestmentsUseCase =
            fetchInvestmentsUseCase ?? FetchInvestmentsUseCase();

  Future<List<Goal>> invoke() async {
    List<GoalDO> goals = await _goalApi.getGoals();
    List<Investment> investments =
        await _fetchInvestmentsUseCase.fetchInvestments();
    List<GoalInvestmentEnrichedMappingDO> goalInvestmentMappings =
        await _goalApi.getGoalInvestmentMappings();

    return goals.map((goal) {
      List<GoalInvestmentEnrichedMappingDO> goalInvestmentOfGoal =
          goalInvestmentMappings
              .where((goalInvestment) => goalInvestment.goalId == goal.id)
              .toList();

      Map<Investment, double> investmentsOfGoal = {};
      for (var goalInvestment in goalInvestmentOfGoal) {
        Investment investment = investments.firstWhere(
            (investment) => investment.id == goalInvestment.investmentId);
        investmentsOfGoal[investment] = goalInvestment.sharePercentage;
      }

      return Goal.from(goal: goal, taggedInvestments: investmentsOfGoal);
    }).toList();
  }

  Future<Goal> getGoal(final int id) async {
    GoalDO goal = await _goalApi.getGoal(id: id);
    List<Investment> investments =
        await _fetchInvestmentsUseCase.fetchInvestments();
    List<GoalInvestmentEnrichedMappingDO> goalInvestmentMapping =
        await _goalApi.getGoalInvestmentMappings(goalId: id);

    Map<Investment, double> investmentsOfGoal = {};
    for (var goalInvestment in goalInvestmentMapping) {
      Investment investment = investments.firstWhere(
          (investment) => investment.id == goalInvestment.investmentId);
      investmentsOfGoal[investment] = goalInvestment.sharePercentage;
    }

    return Goal.from(goal: goal, taggedInvestments: investmentsOfGoal);
  }
}
