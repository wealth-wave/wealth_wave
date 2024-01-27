import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

class GoalHealthEvaluator {
  factory GoalHealthEvaluator() {
    return _instance;
  }

  static final GoalHealthEvaluator _instance = GoalHealthEvaluator._();

  GoalHealthEvaluator._();

  List<String> evaluate(final Goal goal) {
    List<String> healthReport = [];

    String? progressReport = _evaluateProgress(
        valueOnMaturity: goal.valueOnMaturity, expectedValue: goal.amount);
    String? riskCompositionReport = _evaluateRiskComposition(
        riskComposition: goal.riskComposition,
        importance: goal.importance,
        yearsLeft: goal.yearsLeft);
    String? basketCompositionReport =
        _evaluateBasketComposition(basketComposition: goal.basketComposition);

    if (progressReport != null) {
      healthReport.add(progressReport);
    }
    if (riskCompositionReport != null) {
      healthReport.add(riskCompositionReport);
    }
    if (basketCompositionReport != null) {
      healthReport.add(basketCompositionReport);
    }

    return healthReport;
  }

  String? _evaluateProgress(
      {required final valueOnMaturity, required final expectedValue}) {
    if (valueOnMaturity < expectedValue) {
      return 'You are behind your goal by ${formatToCurrency(expectedValue - valueOnMaturity)}. Consider increasing your investments or Start SIP.';
    }

    return null;
  }

  String? _evaluateBasketComposition(
      {required final Map<String, double> basketComposition}) {
    double totalAmount = basketComposition.values.fold(0, (a, b) => a + b);

    for (var entry in basketComposition.entries) {
      if (entry.value / totalAmount > 0.6) {
        return 'Majority of your investment is in the "${entry.key}" basket. Consider diversifying your investments across multiple baskets.';
      }
    }

    return null;
  }

  String? _evaluateRiskComposition(
      {required final Map<RiskLevel, double> riskComposition,
      required final GoalImportance importance,
      required final yearsLeft}) {
    double lowRiskThreshold = importance == GoalImportance.high
        ? 0.6
        : importance == GoalImportance.medium
            ? 0.4
            : 0.2;

    double mediumRiskThreshold = importance == GoalImportance.high
        ? 0.3
        : importance == GoalImportance.medium
            ? 0.2
            : 0.1;

    lowRiskThreshold -= yearsLeft / 100;
    mediumRiskThreshold -= yearsLeft / 100;

    if ((riskComposition[RiskLevel.low] ?? 0) < lowRiskThreshold) {
      return 'Consider having more Low Risk Investment. Required minimum of ${formatToPercentage(lowRiskThreshold * 100, forceRound: true)}';
    }
    if ((riskComposition[RiskLevel.medium] ?? 0) < mediumRiskThreshold &&
        (riskComposition[RiskLevel.low] ?? 0) < mediumRiskThreshold) {
      return 'Consider having more Medium Risk Investment. Required minimum of ${formatToPercentage(mediumRiskThreshold * 100, forceRound: true)}';
    }

    return null;
  }
}
