import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/models/irr_calculator.dart';
import 'package:wealth_wave/domain/models/payment.dart';
import 'package:wealth_wave/domain/models/sip.dart';
import 'package:wealth_wave/domain/models/transaction.dart';

class Investment {
  final int id;
  final String name;
  final String? description;
  final RiskLevel riskLevel;
  final double? value;
  final double? irr;
  final DateTime? maturityDate;
  final int? basketId;
  final String? basketName;
  final int goalsCount;
  final List<Transaction> transactions;
  final List<Sip> sips;

  Investment._(
      {required this.id,
      required this.name,
      required this.description,
      required this.riskLevel,
      required this.irr,
      required this.value,
      required this.basketId,
      required this.maturityDate,
      required this.basketName,
      required this.goalsCount,
      required this.transactions,
      required this.sips});

  double getTotalInvestedAmount({final DateTime? till}) {
    return getPayments(till: till)
        .map((transaction) => transaction.amount)
        .fold(0, (value, element) => value + element);
  }

  DateTime getLastInvestedOn() {
    return getPayments().lastOrNull?.createdOn ?? DateTime.now();
  }

  List<Payment> getPayments(
      {final DateTime? till, bool considerFuturePayments = false}) {
    final payments = transactions
        .where((transaction) =>
            till == null || till.isAfter(transaction.createdOn))
        .map((transaction) => transaction.toPayment())
        .toList(growable: true);
    if (considerFuturePayments && till != null) {
      for (var sip in sips) {
        payments.addAll(sip.getFuturePayment(till: till));
      }
    }
    return payments;
  }

  double getValueOn(
      {required final DateTime date, bool considerFuturePayments = false}) {
    final maturityDate = this.maturityDate;
    final futureDate = maturityDate != null && maturityDate.isBefore(date)
        ? maturityDate
        : date;

    final payments = getPayments(
        till: futureDate, considerFuturePayments: considerFuturePayments);

    final value = this.value;
    final irr = this.irr;
    if (value != null) {
      final irr = IRRCalculator().calculateIRR(
          payments: payments, value: value, valueUpdatedOn: DateTime.now());
      return IRRCalculator().calculateValueOnIRR(
          irr: irr,
          futureDate: futureDate,
          currentValue: value,
          currentValueUpdatedOn: DateTime.now());
    } else if (irr != null) {
      return IRRCalculator().calculateFutureValueOnIRR(
          payments: payments, irr: irr, date: futureDate);
    } else {
      throw Exception('Value and IRR are null');
    }
  }

  double getIRR() {
    final irr = this.irr;
    final value = this.value;
    if (irr != null) {
      return irr;
    } else if (value != null) {
      final List<Payment> payments = getPayments(till: DateTime.now());

      return IRRCalculator().calculateIRR(
          payments: payments, value: value, valueUpdatedOn: DateTime.now());
    } else {
      throw Exception('Value and IRR are null');
    }
  }

  factory Investment.from(
          {required final InvestmentDO investmentDO,
          required final List<TransactionDO> transactionsDOs,
          required final List<SipDO> sipDOs}) =>
      Investment._(
          id: investmentDO.id,
          name: investmentDO.name,
          description: investmentDO.description,
          riskLevel: investmentDO.riskLevel,
          irr: investmentDO.irr,
          value: investmentDO.value,
          basketId: investmentDO.basketId,
          maturityDate: investmentDO.maturityDate,
          basketName: investmentDO.basketName,
          goalsCount: investmentDO.taggedGoals ?? 0,
          transactions: transactionsDOs
              .map((transactionDO) =>
                  Transaction.from(transactionDO: transactionDO))
              .toList(),
          sips: sipDOs.map((sipDO) => Sip.from(sipDO: sipDO)).toList());
}
