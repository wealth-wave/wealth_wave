import 'dart:math';

import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';
import 'package:wealth_wave/utils/ui_utils.dart';
import 'package:wealth_wave/utils/utils.dart';

class CreateGoalPresenter extends Presenter<CreateGoalViewState> {
  final GoalService _goalService;

  CreateGoalPresenter({
    final GoalService? goalService,
  })  : _goalService = goalService ?? GoalService(),
        super(CreateGoalViewState());

  void createGoal({int? goalIdToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String name = viewState.name;
    final String description = viewState.description;
    final double amount = double.tryParse(viewState.amount) ?? 0;
    final DateTime date = parseDate(viewState.date) ?? DateTime.now();
    final DateTime targetDate =
        parseDate(viewState.targetDate) ?? DateTime.now();
    final double inflation = double.tryParse(viewState.inflation) ?? 0;
    final GoalImportance importance = viewState.importance;

    if (goalIdToUpdate != null) {
      _goalService
          .update(
              id: goalIdToUpdate,
              name: name,
              description: description,
              amount: amount,
              amountUpdatedOn: date,
              maturityDate: targetDate,
              inflation: inflation,
              importance: importance)
          .then((_) => updateViewState(
              (viewState) => viewState.onGoalCreated = SingleEvent(null)));
    } else {
      _goalService
          .create(
              name: name,
              description: description,
              amount: amount,
              amountUpdatedOn: date,
              maturityDate: targetDate,
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
    updateViewState((viewState) => viewState.amount = text);
  }

  void dateChanged(String date) {
    updateViewState((viewState) => viewState.date = date);
  }

  void targetDateChanged(String date) {
    updateViewState((viewState) => viewState.targetDate = date);
  }

  void inflationChanged(String text) {
    updateViewState((viewState) => viewState.inflation = text);
  }

  void importanceChanged(GoalImportance importance) {
    updateViewState((viewState) => viewState.importance = importance);
  }

  void _setGoal(Goal goalToUpdate) {
    updateViewState((viewState) {
      viewState.name = goalToUpdate.name;
      viewState.description = goalToUpdate.description ?? '';
      viewState.amount = goalToUpdate.amount.toString();
      viewState.inflation = goalToUpdate.inflation.toString();
      viewState.importance = goalToUpdate.importance;
      viewState.date = formatDate(goalToUpdate.amountUpdatedOn) ?? '';
      viewState.targetDate = formatDate(goalToUpdate.maturityDate) ?? '';
    });
  }

  void fetchGoal({required int id}) {
    _goalService.getBy(id: id).then((goal) => _setGoal(goal));
  }
}

class CreateGoalViewState {
  String name = '';
  String description = '';
  String amount = '';
  String date = '';
  String targetDate = '';
  String inflation = '';
  GoalImportance importance = GoalImportance.high;
  SingleEvent<void>? onGoalCreated;

  double getTargetAmount() {
    final amount = double.tryParse(this.amount) ?? 0;
    final inflation = double.tryParse(this.inflation) ?? 0;
    final date = parseDate(this.date) ?? DateTime.now();
    final targetDate = parseDate(this.targetDate) ?? DateTime.now();
    return amount *
        pow(1 + inflation / 100, targetDate.difference(date).inDays / 365);
  }

  bool isValid() {
    final double? amount = double.tryParse(this.amount);
    final DateTime? date = parseDate(this.date);
    final DateTime? targetDate = parseDate(this.targetDate);
    final double? inflation = double.tryParse(this.inflation);

    final bool isAmountValid = amount != null && amount > 0;
    final bool isDateValid = date != null;
    final bool isTargetDateValid =
        targetDate != null && targetDate.isAfter(DateTime.now());
    final bool isInflationValid =
        inflation != null && inflation >= 0 && inflation <= 100;

    return name.isNotEmpty &&
        isAmountValid &&
        isDateValid &&
        isTargetDateValid &&
        isInflationValid;
  }
}
