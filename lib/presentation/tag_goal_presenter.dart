import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/services/goal_investment_service.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';

class TagGoalPresenter extends Presenter<TagGoalViewState> {
  final int _investmentId;
  final GoalService _goalService;
  final GoalInvestmentService _goalInvestmentService;

  TagGoalPresenter(
      {required final int investmentId,
      final GoalService? goalService,
      final GoalInvestmentService? goalInvestmentService})
      : _investmentId = investmentId,
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
        _goalInvestmentService
            .updateTaggedGoalInvestment(
                id: idToUpdate,
                investmentId: _investmentId,
                goalId: goalId,
                split: sharePercentage)
            .then((_) => updateViewState(
                (viewState) => viewState.onGoalTagged = SingleEvent(null)));
      } else {
        _goalInvestmentService
            .tagGoalInvestment(
                goalId: goalId,
                investmentId: _investmentId,
                split: sharePercentage)
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
        .getById(id: id)
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
