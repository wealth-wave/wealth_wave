import 'dart:math';

import 'package:wealth_wave/domain/models/payment.dart';

class IRRCalculator {
  factory IRRCalculator() {
    return _instance;
  }

  static final IRRCalculator _instance = IRRCalculator._();

  IRRCalculator._();

  double calculateIRR(
      {required final List<Payment> payments,
      required final double value,
      required final DateTime valueUpdatedOn}) {
    if (payments.isEmpty) return 0.0;

    payments.sort((a, b) => a.createdOn.compareTo(b.createdOn));
    DateTime initialDate = payments.first.createdOn;
    List<_CashFlow> cashFlows = payments
        .where((payment) => payment.createdOn
            .isBefore(valueUpdatedOn.subtract(const Duration(days: 1))))
        .toList()
        .map((transaction) {
      double years = transaction.createdOn.difference(initialDate).inDays / 365;
      return _CashFlow(
          amount: -transaction.amount,
          years: years);
    }).toList();

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
      if (f.abs() < 1e-6) return guess * 100; // Convergence tolerance
      guess -= f / df;
    }
    return 0.0;
  }

  double calculateFutureValueOnIRR(
      {required final List<Payment> payments,
      required final double irr,
      required final DateTime date}) {
    double futureValue = 0;

    for (var payment in payments) {
      double years = payment.createdOn.difference(date).inDays / 365;
      futureValue += payment.amount / pow(1 + (irr / 100), years);
    }

    return futureValue;
  }

  double calculateValueOnIRR({
    required final double irr,
    required final DateTime futureDate,
    required final double currentValue,
    required final DateTime currentValueUpdatedOn,
  }) {
    double years = currentValueUpdatedOn.difference(futureDate).inDays / 365;
    return currentValue / pow(1 + irr / 100, years);
  }
}

class _CashFlow {
  final double amount;
  final double years;

  _CashFlow({required this.amount, required this.years});
}
