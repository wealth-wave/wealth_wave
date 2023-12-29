import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/irr_calculator.dart';
import 'package:wealth_wave/domain/transaction_do.dart';

class InvestmentDO {
  final int id;
  final String name;
  final RiskLevel riskLevel;
  final double value;
  final DateTime valueUpdatedOn;
  final int basketId;
  final String basketName;
  final double totalInvestedAmount;
  final int totalTransactions;
  final List<TransactionDO> transactions;

  InvestmentDO(
      {required this.id,
      required this.name,
      required this.riskLevel,
      required this.value,
      required this.valueUpdatedOn,
      required this.basketId,
      required this.basketName,
      required this.totalInvestedAmount,
      required this.totalTransactions,
      required this.transactions});

  double getIrr() {
    return IRRCalculator().calculateIRR(
      transactions: transactions,
      finalValue: value,
      finalDate: valueUpdatedOn,
    );
  }

  static InvestmentDO from(
      {required final InvestmentEnriched investment,
      required final List<InvestmentTransaction> transactions}) {
    return InvestmentDO(
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
            .map((transaction) => TransactionDO.from(transaction: transaction))
            .toList());
  }
}
