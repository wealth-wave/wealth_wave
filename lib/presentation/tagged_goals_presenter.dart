import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class TaggedGoalsPresenter extends Presenter<TaggedGoalsViewState> {
  final int _investmentId;
  final InvestmentService _investmentService;

  TaggedGoalsPresenter(
      {required final int investmentId,
      final InvestmentService? investmentService})
      : _investmentId = investmentId,
        _investmentService = investmentService ?? InvestmentService(),
        super(TaggedGoalsViewState());

  void fetchTaggedInvestment() {
    _investmentService
        .getBy(id: _investmentId)
        .then((investment) => investment.getGoals())
        .then((taggedGoals) => Future.wait(taggedGoals.entries.toList().map(
            (taggedGoal) => TagggedGoalVO.from(
                goal: taggedGoal.key, split: taggedGoal.value))))
        .then((taggedGoalVOs) => updateViewState((viewState) {
              viewState.taggedGoalVOs = taggedGoalVOs;
            }));
  }

  void deleteTaggedInvestment({required final int id}) {
    _investmentService
        .getBy(id: _investmentId)
        .then((investment) => investment.deleteTaggedGoal(id: id))
        .then((value) => fetchTaggedInvestment());
  }
}

class TaggedGoalsViewState {
  List<TagggedGoalVO> taggedGoalVOs = [];

  TaggedGoalsViewState();
}

class TagggedGoalVO {
  final int id;
  final String name;
  final String? description;
  final double amount;
  final DateTime amountUpdatedOn;
  final DateTime maturityDate;
  final double inflation;
  final GoalImportance importance;
  final double splitPercentage;

  TagggedGoalVO(
      {required this.id,
      required this.name,
      required this.description,
      required this.amount,
      required this.amountUpdatedOn,
      required this.maturityDate,
      required this.inflation,
      required this.importance,
      required this.splitPercentage});

  static Future<TagggedGoalVO> from(
      {required final Goal goal, required final double split}) async {
    return Future.value(TagggedGoalVO(
        id: goal.id,
        name: goal.name,
        description: goal.description,
        amount: goal.amount,
        amountUpdatedOn: goal.amountUpdatedOn,
        maturityDate: goal.maturityDate,
        inflation: goal.inflation,
        importance: goal.importance,
        splitPercentage: split));
  }
}
