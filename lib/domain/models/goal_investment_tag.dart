import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/utils/utils.dart';

class GoalInvestmentTag {
  final int id;
  final int investmentId;
  final String investmentName;
  final Investment investment;
  final int goalId;
  final String goalName;
  final DateTime maturityDate;
  final double splitPercentage;

  double get currentValue => calculatePercentageOfValue(
      value: investment.getValue(),
      percentage: splitPercentage);

  int get sipCount => investment.sips.length;

  double get irr => investment.getIRR();

  GoalInvestmentTag._(
      {required this.id,
      required this.investmentId,
      required this.investmentName,
      required this.investment,
      required this.goalId,
      required this.goalName,
      required this.maturityDate,
      required this.splitPercentage});

  factory GoalInvestmentTag.from({
    required GoalInvestmentDO goalInvestmentDO,
    required InvestmentDO investmentDO,
    required List<TransactionDO> transactionsDOs,
    required List<SipDO> sipDOs,
    required ScriptDO? scriptDO,
  }) {
    return GoalInvestmentTag._(
          id: goalInvestmentDO.id,
          investmentId: goalInvestmentDO.investmentId,
          investmentName: goalInvestmentDO.investmentName ?? '',
          maturityDate: goalInvestmentDO.maturityDate ?? DateTime.now(),
          investment: Investment.from(
            scriptDO: scriptDO,
            investmentDO: investmentDO,
            transactionsDOs: transactionsDOs
                .where((element) =>
                      element.investmentId == goalInvestmentDO.investmentId)
                  .toList(),
              sipDOs: sipDOs
                  .where((element) =>
                      element.investmentId == goalInvestmentDO.investmentId)
                  .toList()),
          goalId: goalInvestmentDO.goalId,
          goalName: goalInvestmentDO.goalName ?? '',
          splitPercentage: goalInvestmentDO.splitPercentage);
  }
}
