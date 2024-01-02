import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/irr_calculator.dart';
import 'package:wealth_wave/domain/models/transaction.dart';

class Investment {
  final int id;
  final String name;
  final RiskLevel riskLevel;
  final double value;
  final DateTime valueUpdatedOn;
  final int basketId;
  final String basketName;
  final double totalInvestedAmount;
  final int totalTransactions;
  final List<Transaction> transactions;
  final List<GoalInvestmentEnrichedMappingDO> taggedGoals;

  Investment(
      {required this.id,
      required this.name,
      required this.riskLevel,
      required this.value,
      required this.valueUpdatedOn,
      required this.basketId,
      required this.basketName,
      required this.totalInvestedAmount,
      required this.totalTransactions,
      required this.transactions,
      required this.taggedGoals});

  double? getIrr() {
    return IRRCalculator().calculateIRR(
      transactions: transactions,
      finalValue: value,
      finalDate: valueUpdatedOn,
    );
  }

  static Investment from(
      {required final InvestmentEnrichedDO investment,
      required final List<TransactionDO> transactions,
      required final List<GoalInvestmentEnrichedMappingDO>
          goalInvestmentMappings}) {
    return Investment(
        id: investment.id,
        name: investment.name,
        riskLevel: investment.riskLevel,
        value: investment.value,
        valueUpdatedOn: investment.valueUpdatedOn,
        basketId: investment.basketId ?? 0,
        basketName: investment.basketName ?? '',
        totalInvestedAmount: investment.totalInvestedAmount ?? 0,
        totalTransactions: investment.totalTransactions ?? 0,
        transactions: transactions
            .map((transaction) => Transaction.from(transaction: transaction))
            .toList(),
        taggedGoals: goalInvestmentMappings);
  }
}
