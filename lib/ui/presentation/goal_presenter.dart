import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/domain/services/goal_service.dart';

class GoalPresenter extends Presenter<GoalViewState> {
  final GoalService _goalService;

  GoalPresenter({final GoalService? goalService})
      : _goalService = goalService ?? GoalService(),
        super(GoalViewState());

  void fetchGoal({required final int id}) {
    _goalService.getBy(id: id).then((goal) {
      return GoalVO.from(
          goal: goal,
          goalAmountOverTime: _getGoalValueOverTime(goal),
          investedAmountDataOverTime:
              _getInvestmentOverTime(goal),
          investedValueOverTime: _getValueOverTime(goal));
    }).then((goalVO) {
      updateViewState((viewState) => viewState.goalVO = goalVO);
    });
  }

  Map<DateTime, double> _getGoalValueOverTime(Goal goal) {
    Map<DateTime, double> valueOverTime = {};

    valueOverTime[goal.amountUpdatedOn] = goal.amount;
    valueOverTime[goal.maturityDate] = goal.maturityAmount;

    return valueOverTime;
  }

  Map<DateTime, double> _getInvestmentOverTime(
      Goal goal) {
    Map<DateTime, double> valueOverTime = {};
    Map<DateTime, double> dateInvestmentMap = {};

    goal.taggedInvestments.forEach((investment, percentage) {
      investment
          .getPayments(till: goal.maturityDate)
          .map((e) => MapEntry(e.createdOn, e.amount))
          .forEach((entry) {
        dateInvestmentMap.update(
            entry.key, (value) => value + entry.value * percentage/100,
            ifAbsent: () => entry.value * percentage/100);
      });
      dateInvestmentMap.update(goal.maturityDate, (value) => investment.getTotalInvestedAmount(till: goal.maturityDate) * percentage/100,
            ifAbsent: () => investment.getTotalInvestedAmount(till: goal.maturityDate) * percentage/100);
    });

    List<DateTime> investmentDates = dateInvestmentMap.keys.toList();
    investmentDates.sort((a, b) => a.compareTo(b));

    double previousValue = 0;
    for (var date in investmentDates) {
      double investedAmount = dateInvestmentMap[date] ?? 0;
      double valueSoFar = previousValue + investedAmount;
      valueOverTime[date] = valueSoFar;
      previousValue = valueSoFar;
    }

    return valueOverTime;
  }

  Map<DateTime, double> _getValueOverTime(Goal goal) {
    Map<DateTime, double> valueOverTime = {};
    Map<DateTime, double> dateInvestmentMap = {};
    double totalValue = 0;
    double totalValueOnMaturity = 0;
    double totalInvested = 0;

    goal.taggedInvestments.forEach((investment, percentage) {
      investment
          .getPayments(till: goal.maturityDate)
          .map((e) => MapEntry(e.createdOn, e.amount))
          .forEach((entry) {
        dateInvestmentMap.update(
            entry.key, (value) => value + entry.value * percentage/100,
            ifAbsent: () => entry.value * percentage/100);
      });
      dateInvestmentMap.update(DateTime.now(), (value) => value,ifAbsent: () => 0);
      totalValue += investment.getValueOn(date: DateTime.now()) * percentage/100;
      totalInvested +=
          investment.getTotalInvestedAmount(till: goal.maturityDate) * percentage/100;
      totalValueOnMaturity += investment.getValueOn(date: goal.maturityDate) * percentage/100;
    });

    List<DateTime> investmentDates = dateInvestmentMap.keys.toList();
    investmentDates.sort((a, b) => a.compareTo(b));

    double previousValue = 0;
    for (var date in investmentDates) {
      double proportion = (dateInvestmentMap[date] ?? 0) / totalInvested;
      double value = (proportion * totalValue);
      double valueSoFar = previousValue + value;
      valueOverTime[date] = valueSoFar;
      previousValue = valueSoFar;
    }
    valueOverTime[goal.maturityDate] = totalValueOnMaturity;

    return valueOverTime;
  }
}

class GoalViewState {
  GoalVO? goalVO;
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
  final Map<DateTime, double> goalAmountOverTime;
  final Map<DateTime, double> investmentAmountOverTime;
  final Map<DateTime, double> investedValueOverTime;

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
      ((riskComposition[RiskLevel.veryLow] ?? 0.0) +
          (riskComposition[RiskLevel.low] ?? 0.0)) *
      100;

  double get mediumRiskProgressPercent =>
      (riskComposition[RiskLevel.medium] ?? 0.0) * 100;

  double get highRiskProgressPercent =>
      ((riskComposition[RiskLevel.high] ?? 0.0) +
          (riskComposition[RiskLevel.veryHigh] ?? 0.0)) *
      100;

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
      required this.basketComposition,
      required this.goalAmountOverTime,
      required this.investmentAmountOverTime,
      required this.investedValueOverTime});

  factory GoalVO.from(
      {required final Goal goal,
      required Map<DateTime, double> goalAmountOverTime,
      required Map<DateTime, double> investedAmountDataOverTime,
      required Map<DateTime, double> investedValueOverTime}) {
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
        basketComposition: goal.basketComposition,
        goalAmountOverTime: goalAmountOverTime,
        investmentAmountOverTime: investedAmountDataOverTime,
        investedValueOverTime: investedValueOverTime);
  }
}
