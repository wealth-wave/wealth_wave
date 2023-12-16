import 'dart:math';

import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/use_cases/goal/create_goal_use_case.dart';

class CreateGoalPagePresenter extends Presenter<CreateGoalPageViewState> {
  final CreateGoalUseCase _createGoalUseCase;

  CreateGoalPagePresenter({
    final CreateGoalUseCase? createGoalUseCase,
  })  : _createGoalUseCase = createGoalUseCase ?? CreateGoalUseCase(),
        super(CreateGoalPageViewState());

  void createGoal() {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final name = viewState.name;
    final amount = viewState.amount;
    final date = DateTime.now();
    final targetAmount = viewState.getTargetAmount();
    final targetDate = viewState.targetDate;
    final inflation = viewState.inflation;
    final importance = viewState.importance;

    _createGoalUseCase
        .createGoal(
            name: name,
            amount: amount,
            date: date,
            targetAmount: targetAmount,
            targetDate: targetDate,
            inflation: inflation,
            importance: importance)
        .then((_) => updateViewState(
            (viewState) => viewState.onGoalCreated = SingleEvent(null)));
  }

  void nameChanged(String text) {
    updateViewState((viewState) => viewState.name = text);
  }

  void amountChanged(String text) {
    updateViewState(
        (viewState) => viewState.amount = double.tryParse(text) ?? 0);
  }

  void targetDateChanged(DateTime date) {
    updateViewState((viewState) => viewState.targetDate = date);
  }

  void inflationChanged(double text) {
    updateViewState((viewState) => viewState.inflation = text);
  }

  void importanceChanged(GoalImportance importance) {
    updateViewState((viewState) => viewState.importance = importance);
  }
}

class CreateGoalPageViewState {
  String name = '';
  double amount = 0.0;
  DateTime targetDate = DateTime.now().add(const Duration(days: 365));
  double inflation = 0;
  GoalImportance importance = GoalImportance.high;
  SingleEvent<void>? onGoalCreated;

  double getTargetAmount() {
    final amount = this.amount;
    final inflation = this.inflation;
    final targetDate = this.targetDate;
    return amount *
        pow(1 + inflation / 100,
            targetDate.difference(DateTime.now()).inDays / 365);
  }

  bool isValid() {
    return name.isNotEmpty &&
        amount > 0 &&
        getTargetAmount() > 0 &&
        targetDate.isAfter(DateTime.now()) &&
        inflation >= 0;
  }
}