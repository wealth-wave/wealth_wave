import 'package:wealth_wave/api/db/app_database.dart';

class GoalInvestmentTag {
  final int id;
  final int investmentId;
  final int goalId;
  final double splitPercentage;

  GoalInvestmentTag(
      {required this.id,
      required this.investmentId,
      required this.goalId,
      required this.splitPercentage});

  static Future<GoalInvestmentTag> from(
      {required GoalInvestmentDO goalInvestmentDO}) async {
    return GoalInvestmentTag(
        id: goalInvestmentDO.id,
        investmentId: goalInvestmentDO.investmentId,
        goalId: goalInvestmentDO.goalId,
        splitPercentage: goalInvestmentDO.splitPercentage);
  }
}
