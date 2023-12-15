import 'dart:math';

import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/use_cases/goal/create_goal_use_case.dart';
import 'package:wealth_wave/domain/use_cases/goal/delete_goal_use_case.dart';
import 'package:wealth_wave/domain/use_cases/goal/get_goals_use_case.dart';
import 'package:wealth_wave/domain/use_cases/goal/update_goal_use_case.dart';

class GoalsPagePresenter extends Presenter<GoalsPageViewState> {
  final CreateGoalUseCase _createGoalUseCase;
  final GetGoalsUseCase _getGoalsUseCase;
  final UpdateGoalUseCase _updateGoalUseCase;
  final DeleteGoalUseCase _deleteGoalUseCase;

  GoalsPagePresenter({
    final CreateGoalUseCase? createGoalUseCase,
    final GetGoalsUseCase? getGoalsUseCase,
    final UpdateGoalUseCase? updateGoalUseCase,
    final DeleteGoalUseCase? deleteGoalUseCase,
  })  : _createGoalUseCase = createGoalUseCase ?? CreateGoalUseCase(),
        _getGoalsUseCase = getGoalsUseCase ?? GetGoalsUseCase(),
        _updateGoalUseCase = updateGoalUseCase ?? UpdateGoalUseCase(),
        _deleteGoalUseCase = deleteGoalUseCase ?? DeleteGoalUseCase(),
        super(GoalsPageViewState());

  void fetchGoals() {
    _getGoalsUseCase.getGoals().then((goals) => {
          updateViewState((viewState) {
            viewState.goals = goals;
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
        .then((_) => fetchGoals());
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
        .then((_) => fetchGoals());
  }

  void deleteGoal({required final int id}) {
    _deleteGoalUseCase.deleteGoal(id: id).then((_) => fetchGoals());
  }
}

class GoalsPageViewState {
  List<Goal> goals = [];

  double getTargetAmount(double amount, double inflation, DateTime targetDate) {
    return amount *
        pow(1 + inflation / 100,
            targetDate.difference(DateTime.now()).inDays / 365);
  }
}
