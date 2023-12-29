import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/goal_do.dart';
import 'package:wealth_wave/domain/investment_do.dart';
import 'package:wealth_wave/domain/usecases/fetch_investments_use_case.dart';

class FetchGoalsUseCase {
  final GoalApi _goalApi;
  final FetchInvestmentsUseCase _fetchInvestmentsUseCase;

  FetchGoalsUseCase(
      {GoalApi? goalApi, FetchInvestmentsUseCase? fetchInvestmentsUseCase})
      : _goalApi = goalApi ?? GoalApi(),
        _fetchInvestmentsUseCase =
            fetchInvestmentsUseCase ?? FetchInvestmentsUseCase();

  Future<List<GoalDO>> invoke() async {
    List<Goal> goals = await _goalApi.getGoals();
    List<InvestmentDO> investments =
        await _fetchInvestmentsUseCase.fetchInvestments();
    List<GoalInvestment> goalInvestmentTag =
        await _goalApi.getGoalInvestments();

    return goals.map((goal) {
      List<GoalInvestment> goalInvestmentOfGoal = goalInvestmentTag
          .where((goalInvestment) => goalInvestment.goalId == goal.id)
          .toList();

      Map<InvestmentDO, double> investmentsOfGoal = {};
      goalInvestmentOfGoal.forEach((goalInvestment) {
        InvestmentDO investment = investments.firstWhere(
            (investment) => investment.id == goalInvestment.investmentId);
        investmentsOfGoal[investment] = goalInvestment.sharePercentage;
      });

      return GoalDO.from(goal: goal, taggedInvestments: investmentsOfGoal);
    }).toList();
  }
}
