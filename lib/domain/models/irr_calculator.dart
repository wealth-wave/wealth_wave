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
    if (value == 0) return 0.0;

    payments.sort((a, b) => a.createdOn.compareTo(b.createdOn));

    final totalPayment = _calculateTotalPayment(payments);
    final totalYears = _calculateTotalYears(payments, valueUpdatedOn);

    if (totalPayment == 0) return 0.0;
    if (totalYears == 0) return 0.0;
    if (value - totalPayment == 0) return 0.0;

    double irrGuess = (((value - totalPayment)/totalPayment) * 100)/(totalYears);

    final int maxIterations = 1000;
    final double precision = 0.0001;

    for (var i = 0; i < maxIterations; i++) {
      final valueOnIrr = calculateFutureValueOnIRR(
          payments: payments, irr: irrGuess, date: valueUpdatedOn);
      final diff = (value - valueOnIrr) / value;

      if (diff.abs() < precision) {
        break;
      }

      irrGuess += _calculateScale(diff) * diff;
    }

    return irrGuess;
  }

  double _calculateTotalPayment(List<Payment> payments) {
    return payments.fold(0.0, (value, element) => value + element.amount);
  }

  double _calculateTotalYears(List<Payment> payments, DateTime valueUpdatedOn) {
    return valueUpdatedOn.difference(payments.first.createdOn).inDays / 365;
  }

  double _calculateScale(double diff) {
    if (diff.abs() > 0.05) {
      return 20.0;
    } else if (diff.abs() > 0.01) {
      return 10.0;
    } else if (diff.abs() > 0.001) {
      return 5.0;
    } else {
      return 2.0;
    }
  }

  double calculateFutureValueOnIRR(
      {required final List<Payment> payments,
      required final double irr,
      required final DateTime date}) {
    double futureValue = 0;

    for (var payment in payments) {
      double years = payment.createdOn.difference(date).inDays / 365;
      if(years == 0) {
        futureValue += payment.amount;
      } else {
        futureValue += payment.amount / pow(1 + (irr / 100), years);
      }
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