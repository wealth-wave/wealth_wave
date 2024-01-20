import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/services/goal_investment_service.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class TagGoalPresenter extends Presenter<TagGoalViewState> {
  final int _investmentId;
  final InvestmentService _investmentService;
  final GoalService _goalService;
  final GoalInvestmentService _goalInvestmentService;

  TagGoalPresenter(
      {required final int investmentId,
      final InvestmentService? investmentService,
      final GoalService? goalService,
      final GoalInvestmentService? goalInvestmentService})
      : _investmentId = investmentId,
        _investmentService = investmentService ?? InvestmentService(),
        _goalService = goalService ?? GoalService(),
        _goalInvestmentService =
            goalInvestmentService ?? GoalInvestmentService(),
        super(TagGoalViewState());

  void onGoalSelected(int? goalId) {
    updateViewState((viewState) => viewState.goalId = goalId);
  }

  void fetchGoals() {
    _goalService.get().then(
        (goals) => updateViewState((viewState) => viewState.goals = goals));
  }

  void tagGoal({final int? idToUpdate}) {
    final double sharePercentage = getViewState().sharePercentage;
    final int? goalId = getViewState().goalId;
    if (goalId != null && sharePercentage > 0) {
      if (idToUpdate != null) {
        _investmentService
            .getBy(id: _investmentId)
            .then((investment) => investment.updateTaggedGoal(
                id: idToUpdate, goalId: goalId, split: sharePercentage))
            .then((_) => updateViewState(
                (viewState) => viewState.onGoalTagged = SingleEvent(null)));
      } else {
        _investmentService
            .getBy(id: _investmentId)
            .then((investment) =>
                investment.tagGoal(goalId: goalId, split: sharePercentage))
            .then((_) => updateViewState(
                (viewState) => viewState.onGoalTagged = SingleEvent(null)));
      }
    }
  }

  void onPercentageChanged(double text) {
    updateViewState((viewState) => viewState.sharePercentage = text);
  }

  void loadTaggedGoal({required final int id}) {
    _goalInvestmentService
        .getBy(id: id)
        .then((goalInvestment) => updateViewState((viewState) {
              viewState.goalId = goalInvestment.goalId;
              viewState.sharePercentage = goalInvestment.splitPercentage;
              viewState.onGoalTagLoaded = SingleEvent(null);
            }));
  }
}

class TagGoalViewState {
  int? goalId;
  double sharePercentage = 100;
  List<Goal> goals = [];
  SingleEvent<void>? onGoalTagged;
  SingleEvent<void>? onGoalTagLoaded;

  bool isValid() {
    return goalId != null && sharePercentage > 0;
  }
}
