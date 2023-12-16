import 'dart:math';

import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/use_cases/goal/create_goal_use_case.dart';
import 'package:wealth_wave/domain/use_cases/goal/get_goal_use_case.dart';
import 'package:wealth_wave/domain/use_cases/goal/update_goal_use_case.dart';

class CreateGoalPagePresenter extends Presenter<CreateGoalPageViewState> {
  final CreateGoalUseCase _createGoalUseCase;
  final UpdateGoalUseCase _updateGoalUseCase;
  final GetGoalUseCase _getGoalUseCase;

  CreateGoalPagePresenter({
    final CreateGoalUseCase? createGoalUseCase,
    final GetGoalUseCase? getGoalUseCase,
    final UpdateGoalUseCase? updateGoalUseCase,
  })  : _createGoalUseCase = createGoalUseCase ?? CreateGoalUseCase(),
        _getGoalUseCase = getGoalUseCase ?? GetGoalUseCase(),
        _updateGoalUseCase = updateGoalUseCase ?? UpdateGoalUseCase(),
        super(CreateGoalPageViewState());

  void fetchGoal({required final int id}) {
    _getGoalUseCase.getGoal(id: id).then((goal) => {
          updateViewState((viewState) {
            viewState.id = goal.id;
            viewState.name = goal.name;
            viewState.targetAmount = goal.targetAmount;
            viewState.targetDate = goal.targetDate;
            viewState.inflation = goal.inflation;
            viewState.importance = goal.importance;
          })
        });
  }

  void createGoal(
      {required final String name,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) {
    _createGoalUseCase
        .createGoal(
            name: name,
            targetAmount: targetAmount,
            targetDate: targetDate,
            inflation: inflation,
            importance: importance)
        .then((_) =>
            updateViewState((viewState) => viewState.onCompleted = true));
  }

  void updateGoal(
      {required final int id,
      required final String name,
      required final double targetAmount,
      required final DateTime targetDate,
      required final double inflation,
      required final GoalImportance importance}) {
    _updateGoalUseCase
        .update(
            id: id,
            name: name,
            targetAmount: targetAmount,
            targetDate: targetDate,
            inflation: inflation,
            importance: importance)
        .then((_) =>
            updateViewState((viewState) => viewState.onCompleted = true));
  }
}

class CreateGoalPageViewState {
  int? id;
  String? name;
  double? targetAmount;
  DateTime? targetDate;
  double? inflation;
  GoalImportance? importance;
  bool onCompleted = false;

  double getTargetAmount() {
    var amount = targetAmount ?? 0;
    var inflation = this.inflation ?? 0;
    var targetDate = this.targetDate ?? DateTime.now();
    return amount *
        pow(1 + inflation / 100,
            targetDate.difference(DateTime.now()).inDays / 365);
  }
}
