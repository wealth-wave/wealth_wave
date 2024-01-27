import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal_investment_tag.dart';
import 'package:wealth_wave/domain/services/goal_investment_service.dart';

class TaggedInvestmentPresenter extends Presenter<TaggedInvestmentsViewState> {
  final int _goalId;
  final GoalInvestmentService _goalInvestmentService;

  TaggedInvestmentPresenter(
      {required final int goalId,
      final GoalInvestmentService? goalInvestmentService})
      : _goalId = goalId,
        _goalInvestmentService =
            goalInvestmentService ?? GoalInvestmentService(),
        super(TaggedInvestmentsViewState());

  void fetchTaggedInvestment() {
    _goalInvestmentService
        .getBy(goalId: _goalId)
        .then((taggedInvestments) => taggedInvestments
            .map((taggedInvestment) =>
                TaggedInvestmentVO.from(goalInvestmentTag: taggedInvestment))
            .toList())
        .then((taggedInvestmentVOs) => updateViewState((viewState) {
              viewState.taggedInvestmentVOs = taggedInvestmentVOs;
            }));
  }

  void deleteTaggedInvestment({required final int id}) {
    _goalInvestmentService
        .deleteTaggedGoal(id: id)
        .then((_) => fetchTaggedInvestment());
  }
}

class TaggedInvestmentsViewState {
  List<TaggedInvestmentVO> taggedInvestmentVOs = [];
}

class TaggedInvestmentVO {
  final int id;
  final String investmentName;
  final double split;
  final double currentValue;
  final int sipCount;
  final double irr;

  TaggedInvestmentVO(
      {required this.id,
      required this.investmentName,
      required this.split,
      required this.currentValue,
      required this.sipCount,
      required this.irr});

  factory TaggedInvestmentVO.from(
      {required final GoalInvestmentTag goalInvestmentTag}) {
    return TaggedInvestmentVO(
      id: goalInvestmentTag.id,
      investmentName: goalInvestmentTag.investmentName,
      split: goalInvestmentTag.splitPercentage,
      currentValue: goalInvestmentTag.currentValue,
      irr: goalInvestmentTag.irr,
      sipCount: goalInvestmentTag.sipCount,
    );
  }
}
