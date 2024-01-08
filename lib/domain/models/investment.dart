import 'dart:math';

import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/irr_calculator.dart';
import 'package:wealth_wave/domain/models/sip.dart';
import 'package:wealth_wave/domain/models/transaction.dart';

class Investment {
  final int id;
  final String name;
  final String? description;
  final RiskLevel riskLevel;
  final double? currentValue;
  final double? irr;
  final DateTime? currentValueUpdatedOn;
  final DateTime? maturityDate;
  final int? basketId;
  final String? basketName;
  final double totalInvestedAmount;
  final int totalTransactions;
  final List<Transaction> transactions;
  final List<SIP> sips;
  final List<GoalInvestmentEnrichedMappingDO> taggedGoals;

  Investment(
      {required this.id,
      required this.name,
      required this.description,
      required this.riskLevel,
      required this.irr,
      required this.currentValue,
      required this.currentValueUpdatedOn,
      required this.basketId,
      required this.basketName,
      required this.maturityDate,
      required this.totalInvestedAmount,
      required this.totalTransactions,
      required this.transactions,
      required this.sips,
      required this.taggedGoals});

  double? getIrr() {
    if (irr != null) {
      return irr;
    } else if (currentValue != null && currentValueUpdatedOn != null) {
      return IRRCalculator().calculateIRR(
        transactions: transactions,
        finalValue: currentValue!,
        finalDate: currentValueUpdatedOn!,
      );
    }

    return null;
  }

  double getFutureValueOn({required DateTime date, required bool considerFutureTransactions}) {
    double? irr = getIrr();
    if (currentValue != null) {
      if (irr == null) {
        return currentValue!;
      } else {
        return currentValue! *
            pow(1 + irr, date.difference(currentValueUpdatedOn!).inDays / 365);
      }
    } else {
      if (irr == null) {
        return 0;
      }
      double futureValue = 0;
      for (var transaction in transactions) {
        //TODO consider maturity date of investment
        //TODO filter transaction above the date given.
        double years = date.difference(transaction.createdOn).inDays / 365;
        futureValue += transaction.amount / pow(1 + irr, years);
      }
      for(var sip in sips) {
        //Include future value of sip.
      }

      return futureValue;
    }
  }

  static Investment from(
      {required final InvestmentEnrichedDO investment,
      required final List<TransactionDO> transactions,
      required final List<SipDO> sips,
      required final List<GoalInvestmentEnrichedMappingDO>
          goalInvestmentMappings}) {
    return Investment(
        id: investment.id,
        name: investment.name,
        description: investment.description,
        riskLevel: investment.riskLevel,
        maturityDate: investment.maturityDate,
        currentValue: investment.currentValue,
        currentValueUpdatedOn: investment.currentValueUpdatedOn,
        irr: investment.irr,
        basketId: investment.basketId ?? 0,
        basketName: investment.basketName ?? '',
        totalInvestedAmount: investment.totalInvestedAmount ?? 0,
        totalTransactions: investment.totalTransactions ?? 0,
        transactions: transactions
            .map((transaction) => Transaction.from(transaction: transaction))
            .toList(),
        sips: sips.map((sip) => SIP.from(sip: sip)).toList(),
        taggedGoals: goalInvestmentMappings);
  }
}
