import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal_investment_tag.dart';
import 'package:wealth_wave/domain/services/goal_investment_service.dart';

class TaggedGoalsPresenter extends Presenter<TaggedGoalsViewState> {
  final int _investmentId;
  final GoalInvestmentService _goalInvestmentService;

  TaggedGoalsPresenter(
      {required final int investmentId,
      final GoalInvestmentService? goalInvestmentService})
      : _investmentId = investmentId,
        _goalInvestmentService =
            goalInvestmentService ?? GoalInvestmentService(),
        super(TaggedGoalsViewState());

  void fetchTaggedInvestment() {
    _goalInvestmentService
        .getBy(investmentId: _investmentId)
        .then((taggedGoals) => taggedGoals
            .map((taggedGoal) =>
                TaggedGoalVO.from(goalInvestmentTag: taggedGoal))
            .toList())
        .then((taggedGoalVOs) => updateViewState((viewState) {
              viewState.taggedGoalVOs = taggedGoalVOs;
            }));
  }

  void deleteTaggedInvestment({required final int id}) {
    _goalInvestmentService
        .deleteTaggedGoal(id: id)
        .then((value) => fetchTaggedInvestment());
  }
}

class TaggedGoalsViewState {
  List<TaggedGoalVO> taggedGoalVOs = [];

  TaggedGoalsViewState();
}

class TaggedGoalVO {
  final int id;
  final String goalName;
  final double split;
  final double currentValue;
  final int sipCount;
  final double irr;

  TaggedGoalVO(
      {required this.id,
      required this.goalName,
      required this.split,
      required this.currentValue,
      required this.sipCount,
      required this.irr});

  factory TaggedGoalVO.from(
      {required final GoalInvestmentTag goalInvestmentTag}) {
    return TaggedGoalVO(
        id: goalInvestmentTag.id,
        goalName: goalInvestmentTag.goalName,
        split: goalInvestmentTag.splitPercentage,
        currentValue: goalInvestmentTag.currentValue,
        irr: goalInvestmentTag.irr,
        sipCount: goalInvestmentTag.sipCount);
  }
}
