import 'dart:math';

import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/goal.dart';

class CreateGoalPresenter extends Presenter<CreateGoalViewState> {
  final GoalApi _goalApi;

  CreateGoalPresenter({
    final GoalApi? goalApi,
  })  : _goalApi = goalApi ?? GoalApi(),
        super(CreateGoalViewState());

  void createGoal({int? goalIdToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final name = viewState.name;
    final description = viewState.description;
    final amount = viewState.amount;
    final date = viewState.date;
    final targetAmount = viewState.getTargetAmount();
    final targetDate = viewState.targetDate;
    final inflation = viewState.inflation;
    final importance = viewState.importance;

    if (goalIdToUpdate != null) {
      _goalApi
          .update(
              id: goalIdToUpdate,
              name: name,
              description: description,
              amount: amount,
              date: date,
              targetAmount: targetAmount,
              targetDate: targetDate,
              inflation: inflation,
              importance: importance)
          .then((_) => updateViewState(
              (viewState) => viewState.onGoalCreated = SingleEvent(null)));
    } else {
      _goalApi
          .createGoal(
              name: name,
              description: description,
              amount: amount,
              date: date,
              targetAmount: targetAmount,
              targetDate: targetDate,
              inflation: inflation,
              importance: importance)
          .then((_) => updateViewState(
              (viewState) => viewState.onGoalCreated = SingleEvent(null)));
    }
  }

  void nameChanged(String text) {
    updateViewState((viewState) => viewState.name = text);
  }

  void descriptionChanged(String text) {
    updateViewState((viewState) => viewState.description = text);
  }

  void amountChanged(String text) {
    updateViewState(
        (viewState) => viewState.amount = double.tryParse(text) ?? 0);
  }

  void dateChanged(DateTime date) {
    updateViewState((viewState) => viewState.date = date);
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

  void setGoal(Goal goalToUpdate) {
    updateViewState((viewState) {
      viewState.name = goalToUpdate.name;
      viewState.description = goalToUpdate.description;
      viewState.amount = goalToUpdate.amount;
      viewState.inflation = goalToUpdate.inflation;
      viewState.importance = goalToUpdate.importance;
      viewState.date = goalToUpdate.createdDate;
      viewState.targetDate = goalToUpdate.targetDate;
    });
  }
}

class CreateGoalViewState {
  String name = '';
  String? description;
  double amount = 0.0;
  DateTime date = DateTime.now();
  DateTime targetDate = DateTime.now().add(const Duration(days: 365));
  double inflation = 0;
  GoalImportance importance = GoalImportance.high;
  SingleEvent<void>? onGoalCreated;

  double getTargetAmount() {
    final amount = this.amount;
    final inflation = this.inflation;
    final targetDate = this.targetDate;
    return amount *
        pow(1 + inflation / 100, targetDate.difference(date).inDays / 365);
  }

  bool isValid() {
    return name.isNotEmpty &&
        amount > 0 &&
        getTargetAmount() > 0 &&
        targetDate.isAfter(DateTime.now()) &&
        inflation >= 0;
  }
}
