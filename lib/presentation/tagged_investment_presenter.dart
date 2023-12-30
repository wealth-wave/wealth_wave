import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/usecases/fetch_goals_use_case.dart';

class TaggedInvestmentPresenter extends Presenter<TaggedInvestmentsViewState> {
  final FetchGoalsUseCase _fetchGoalsUseCase;
  final GoalApi _goalApi;
  final int goalId;

  TaggedInvestmentPresenter(this.goalId,
      {final FetchGoalsUseCase? fetchGoalsUseCase, final GoalApi? goalApi})
      : _fetchGoalsUseCase = fetchGoalsUseCase ?? FetchGoalsUseCase(),
        _goalApi = goalApi ?? GoalApi(),
        super(TaggedInvestmentsViewState(goalId: goalId));

  void fetchTaggedInvestment() {
    _fetchGoalsUseCase.getGoal(goalId).then((goal) {
      updateViewState((viewState) {
        viewState.taggedInvestments = goal.taggedInvestments;
      });
    });
  }

  void updateTaggedInvestment(
      int id, int investmentId, double sharePercentage) {
    _goalApi
        .updateGoalInvestmentMap(
            goalId: goalId,
            investmentId: investmentId,
            percentage: sharePercentage)
        .then((_) {
      fetchTaggedInvestment();
    });
  }

  void deleteTaggedInvestment(
      {required final int goalId, required final int investmentId}) {
    _goalApi
        .deleteGoalInvestmentMap(goalId: goalId, investmentId: investmentId)
        .then((_) {
      fetchTaggedInvestment();
    });
  }
}

class TaggedInvestmentsViewState {
  final int goalId;
  Map<Investment, double> taggedInvestments = {};

  TaggedInvestmentsViewState({required this.goalId});
}
