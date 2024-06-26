import 'dart:math';

import 'package:wealth_wave/domain/models/payment.dart';

class IRRCalculator {
  factory IRRCalculator() {
    return _instance;
  }

  static final IRRCalculator _instance = IRRCalculator._();

  IRRCalculator._();

  double calculateIRR({required final List<Payment> payments,
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

    double irrGuess = _calculateInitialIRR(
        value: value, totalPayment: totalPayment, totalYears: totalYears);

    const int maxIterations = 1000;
    const double precision =
        0.0001; //This precision gives more accurate result within 1000 iterations

    for (var i = 0; i < maxIterations; i++) {
      final valueOnIrr = calculateFutureValueOnIRR(
          payments: payments, irr: irrGuess, futureDate: valueUpdatedOn);
      final diff = (value - valueOnIrr) / value;

      if (diff.abs() < precision) {
        break;
      }

      irrGuess += _calculateScale(diff) * diff;
    }

    if (irrGuess.isNaN) {
      return 0.0;
    } else if (irrGuess.isInfinite) {
      return 0.0;
    } else if (irrGuess > 100) {
      return 100.0;
    } else if (irrGuess < -100) {
      return -100.0;
    }
    return irrGuess;
  }

  double _calculateInitialIRR({required final double value,
    required final double totalPayment,
    required final double totalYears}) {
    final double baseIRR = ((value - totalPayment) / totalPayment) * 100;
    return totalYears < 1 ? baseIRR : baseIRR / totalYears;
  }

  double _calculateTotalPayment(List<Payment> payments) {
    return payments.fold(0.0, (value, element) => value + element.amount);
  }

  double _calculateTotalYears(List<Payment> payments, DateTime valueUpdatedOn) {
    return valueUpdatedOn
        .difference(payments.first.createdOn)
        .inDays / 365;
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

  double calculateFutureValueOnIRR({required final List<Payment> payments,
    required final double irr,
    required final DateTime futureDate}) {
    double futureValue = 0;

    for (var payment in payments) {
      double years = payment.createdOn
          .difference(futureDate)
          .inDays / 365;
      if (years == 0) {
        futureValue += payment.amount;
      } else if (years < 1 && years > 0) {
        futureValue += payment.amount / pow(1 + (irr / 100), 1);
      } else if (years > -1 && years < 0) {
        futureValue += payment.amount / pow(1 + (irr / 100), -1);
      } else {
        futureValue += payment.amount / pow(1 + (irr / 100), years);
      }
    }

    if (futureValue.isNaN) return 0.0;
    if (futureValue.isInfinite) return 0.0;
    return futureValue;
  }

  double calculateValueOnIRR({
    required final double irr,
    required final DateTime futureDate,
    required final double currentValue,
    required final DateTime currentValueUpdatedOn,
  }) {
    double years = currentValueUpdatedOn.difference(futureDate).inDays / 365;
    if (years == 0) {
      return currentValue;
    } else if (years < 1 && years > 0) {
      return currentValue / pow(1 + irr / 100, 1);
    } else if (years > -1 && years < 0) {
      return currentValue / pow(1 + irr / 100, -1);
    } else {
      return currentValue / pow(1 + irr / 100, years);
    }
  }
}