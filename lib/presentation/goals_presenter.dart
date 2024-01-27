import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';

class GoalsPresenter extends Presenter<GoalsViewState> {
  final GoalService _goalService;

  GoalsPresenter({final GoalService? goalService})
      : _goalService = goalService ?? GoalService(),
        super(GoalsViewState());

  void fetchGoals() {
    _goalService
        .get()
        .then((goals) => goals.map((goal) => GoalVO.from(goal: goal)).toList())
        .then((goalVOs) =>
            updateViewState((viewState) => viewState.goalVOs = goalVOs));
  }

  void deleteGoal({required final int id}) {
    _goalService.deleteBy(id: id).then((_) => fetchGoals());
  }
}

class GoalsViewState {
  List<GoalVO> goalVOs = [];
}

class GoalVO {
  final int id;
  final String name;
  final String? description;
  final double maturityAmount;
  final double investedAmount;
  final DateTime maturityDate;
  final double currentValue;
  final double valueOnMaturity;
  final double inflation;
  final double irr;
  final GoalImportance importance;
  final List<String> healthSuggestions;
  final int taggedInvestmentCount;
  final Map<RiskLevel, double> riskComposition;
  final Map<String, double> basketComposition;

  double get yearsLeft => maturityDate.difference(DateTime.now()).inDays / 365;

  double get currentProgressPercent {
    double progress = (currentValue / maturityAmount) * 100;
    if (progress > 100) {
      return 100;
    } else {
      return progress;
    }
  }

  double get maturityProgressPercent {
    double progress = (valueOnMaturity / maturityAmount) * 100;
    if (progress > 100) {
      return 100;
    } else {
      return progress;
    }
  }

  double get pendingProgressPercent => 100 - maturityProgressPercent;

  double get lowRiskProgressPercent =>
      (riskComposition[RiskLevel.low] ?? 0.0) * 100;

  double get mediumRiskProgressPercent =>
      (riskComposition[RiskLevel.medium] ?? 0.0) * 100;

  double get highRiskProgressPercent =>
      (riskComposition[RiskLevel.high] ?? 0.0) * 100;

  GoalVO._(
      {required this.id,
      required this.name,
      required this.description,
      required this.maturityAmount,
      required this.maturityDate,
      required this.currentValue,
      required this.valueOnMaturity,
      required this.investedAmount,
      required this.importance,
      required this.inflation,
      required this.irr,
      required this.healthSuggestions,
      required this.taggedInvestmentCount,
      required this.riskComposition,
      required this.basketComposition});

  factory GoalVO.from({required final Goal goal}) {
    return GoalVO._(
        id: goal.id,
        name: goal.name,
        description: goal.description,
        importance: goal.importance,
        inflation: goal.inflation,
        currentValue: goal.value,
        maturityAmount: goal.maturityAmount,
        investedAmount: goal.investedAmount,
        maturityDate: goal.maturityDate,
        irr: goal.irr,
        healthSuggestions: goal.healthSuggestions,
        valueOnMaturity: goal.valueOnMaturity,
        taggedInvestmentCount: goal.taggedInvestments.length,
        riskComposition: goal.riskComposition,
        basketComposition: goal.basketComposition);
  }
}
