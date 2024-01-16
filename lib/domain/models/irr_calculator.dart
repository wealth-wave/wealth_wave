import 'dart:math';

import 'package:wealth_wave/domain/models/payment.dart';

class IRRCalculator {
  double? calculateIRR(
      {required final List<Payment> payments,
      required final double value,
      required final DateTime valueUpdatedOn}) {
    if (payments.isEmpty) return null;

    payments.sort((a, b) => a.createdOn.compareTo(b.createdOn));
    DateTime initialDate = payments.first.createdOn;
    List<_CashFlow> cashFlows = payments
        .map((transaction) => _CashFlow(
            amount: -transaction.amount,
            years: transaction.createdOn.difference(initialDate).inDays / 365))
        .toList();

    cashFlows.add(_CashFlow(
        amount: value,
        years: valueUpdatedOn.difference(initialDate).inDays / 365));

    double guess = 0.1; // Initial guess for IRR
    for (int i = 0; i < 100; i++) {
      // Limit iterations to prevent infinite loop
      double f = 0, df = 0;
      for (var cashFlow in cashFlows) {
        num r = pow(1 + guess, cashFlow.years);
        f += cashFlow.amount / r;
        df -= cashFlow.years * cashFlow.amount / (r * (1 + guess));
      }
      if (f.abs() < 1e-6) return guess; // Convergence tolerance
      guess -= f / df; // Newton-Raphson update
    }
    return null;
  }

  double calculateTransactedValueOnIRR(
      {required final List<Payment> payments,
      required final double irr,
      required final DateTime date}) {
    double futureValue = 0;

    for (var transaction in payments) {
      double years = date.difference(transaction.createdOn).inDays / 365;
      futureValue += transaction.amount / pow(1 + irr, years);
    }

    return futureValue;
  }

  double calculateValueOnIRR({
    required final double irr,
    required final DateTime date,
    required final double value,
    required final DateTime valueUpdatedOn,
  }) {
    double years = date.difference(valueUpdatedOn).inDays / 365;
    return value / pow(1 + irr, years);
  }
}

class _CashFlow {
  final double amount;
  final double years;

  _CashFlow({required this.amount, required this.years});
}
