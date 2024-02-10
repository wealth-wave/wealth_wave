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

    var irr = 0.1;
    for (var i = 0; i < 1000; i++) {
      final irrValue = calculateFutureValueOnIRR(
          payments: payments, irr: irr, date: valueUpdatedOn);
      if (irrValue < value && 1-(irrValue/value) > 0.01) {
        irr += 1-(irrValue/value);
      } else if(irrValue > value && 1-(value/irrValue) > 0.01){
        irr -= 1-(value/irrValue);
      } else {
        break;
      }
    }


    return irr;
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
