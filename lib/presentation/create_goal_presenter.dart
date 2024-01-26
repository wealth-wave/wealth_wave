import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';
import 'package:wealth_wave/domain/models/irr_calculator.dart';

class CreateGoalPresenter extends Presenter<CreateGoalViewState> {
  final GoalService _goalService;
  final IRRCalculator _irrCalculator;

  CreateGoalPresenter({
    final GoalService? goalService,
    final IRRCalculator? irrCalculator,
  })  : _goalService = goalService ?? GoalService(),
        _irrCalculator = irrCalculator ?? IRRCalculator(),
        super(CreateGoalViewState());

  void createGoal({int? idToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String name = viewState.name;
    final String description = viewState.description;
    final double amount = viewState.amount;
    final DateTime date = viewState.date;
    final DateTime targetDate = viewState.targetDate;
    final double inflation = viewState.inflation;
    final GoalImportance importance = viewState.importance;

    if (idToUpdate != null) {
      _goalService
          .update(
              id: idToUpdate,
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

  void amountChanged(double value) {
    updateViewState((viewState) {
      viewState.amount = value;
      _updateTargetAmount();
    });
  }

  void dateChanged(DateTime date) {
    updateViewState((viewState) {
      _updateTargetAmount();
      viewState.date = date;
    });
  }

  void targetDateChanged(DateTime date) {
    updateViewState((viewState) {
      viewState.targetDate = date;
      _updateTargetAmount();
    });
  }

  void inflationChanged(double value) {
    updateViewState((viewState) {
      viewState.inflation = value;
      _updateTargetAmount();
    });
  }

  void importanceChanged(GoalImportance importance) {
    updateViewState((viewState) => viewState.importance = importance);
  }

  void _setGoal(Goal goalToUpdate) {
    updateViewState((viewState) {
      viewState.name = goalToUpdate.name;
      viewState.description = goalToUpdate.description ?? '';
      viewState.amount = goalToUpdate.amount;
      viewState.inflation = goalToUpdate.inflation;
      viewState.importance = goalToUpdate.importance;
      viewState.date = goalToUpdate.amountUpdatedOn;
      viewState.targetDate = goalToUpdate.maturityDate;
      viewState.onDataLoaded = SingleEvent(null);
      _updateTargetAmount();
    });
  }

  void fetchGoal({required int id}) {
    _goalService.getBy(id: id).then((goal) => _setGoal(goal));
  }

  void _updateTargetAmount() {
    final viewState = getViewState();
    final double amount = viewState.amount;
    final DateTime date = viewState.date;
    final DateTime targetDate = viewState.targetDate;
    final double inflation = viewState.inflation;

    final double targetAmount = _irrCalculator.calculateValueOnIRR(
        irr: inflation,
        futureDate: targetDate,
        currentValue: amount,
        currentValueUpdatedOn: date);

    viewState.targetAmount = targetAmount;
  }
}

class CreateGoalViewState {
  String name = '';
  String description = '';
  double amount = 0;
  double targetAmount = 0;
  DateTime date = DateTime.now();
  DateTime targetDate = DateTime.now().add(const Duration(days: 365));
  double inflation = 5;
  GoalImportance importance = GoalImportance.high;
  SingleEvent<void>? onGoalCreated;
  SingleEvent<void>? onDataLoaded;

  bool isValid() {
    final bool isAmountValid = amount > 0;
    final bool isTargetDateValid = targetDate.isAfter(DateTime.now());
    final bool isInflationValid = inflation >= 0 && inflation <= 100;

    return name.isNotEmpty &&
        isAmountValid &&
        isTargetDateValid &&
        isInflationValid;
  }
}
