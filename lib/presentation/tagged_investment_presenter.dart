import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';

class TaggedInvestmentPresenter extends Presenter<TaggedInvestmentsViewState> {
  final int _goalId;
  final GoalService _goalService;

  TaggedInvestmentPresenter(
      {required final int goalId, final GoalService? goalService})
      : _goalId = goalId,
        _goalService = goalService ?? GoalService(),
        super(TaggedInvestmentsViewState());

  void fetchTaggedInvestment() {
    _goalService
        .getBy(id: _goalId)
        .then((goal) => goal.getInvestments())
        .then((taggedInvestments) => Future.wait(taggedInvestments.entries
            .toList()
            .map((taggedInvestmentEntry) => TaggedInvestmentVO.from(
                investment: taggedInvestmentEntry.key,
                split: taggedInvestmentEntry.value))))
        .then((taggedInvestmentVOs) => updateViewState((viewState) {
              viewState.taggedInvestmentVOs = taggedInvestmentVOs;
            }));
  }

  void deleteTaggedInvestment({required final int investmentId}) {
    _goalService
        .getBy(id: _goalId)
        .then((goal) => goal.deleteTaggedInvestment(investmentId: investmentId))
        .then((_) => fetchTaggedInvestment());
  }
}

class TaggedInvestmentsViewState {
  List<TaggedInvestmentVO> taggedInvestmentVOs = [];
}

class TaggedInvestmentVO {
  final int id;
  final String name;
  final String? description;
  final RiskLevel riskLevel;
  final double? value;
  final double split;

  TaggedInvestmentVO(
      {required this.id,
      required this.name,
      required this.description,
      required this.riskLevel,
      required this.value,
      required this.split});

  static Future<TaggedInvestmentVO> from(
      {required final Investment investment,
      required final double split}) async {
    return TaggedInvestmentVO(
        id: investment.id,
        name: investment.name,
        description: investment.description,
        riskLevel: investment.riskLevel,
        value: investment.value,
        split: split);
  }
}
