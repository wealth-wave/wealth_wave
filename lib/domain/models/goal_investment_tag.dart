import 'package:wealth_wave/api/db/app_database.dart';

class GoalInvestmentTag {
  final int id;
  final int investmentId;
  final String investmentName;
  final int goalId;
  final String goalName;
  final double splitPercentage;

  GoalInvestmentTag(
      {required this.id,
      required this.investmentId,
      required this.investmentName,
      required this.goalId,
      required this.goalName,
      required this.splitPercentage});

  static Future<GoalInvestmentTag> from(
      {required GoalInvestmentDO goalInvestmentDO}) async {
    return GoalInvestmentTag(
        id: goalInvestmentDO.id,
        investmentId: goalInvestmentDO.investmentId,
        investmentName: goalInvestmentDO.investmentName ?? '',
        goalId: goalInvestmentDO.goalId,
        goalName: goalInvestmentDO.goalName ?? '',
        splitPercentage: goalInvestmentDO.splitPercentage);
  }
}
