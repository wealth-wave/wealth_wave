import 'dart:math';

class IRRCalculator {
  double calculateIRR(
      {required final List<Transaction> transactions,
      required final double finalValue,
      required final DateTime finalDate}) {
    transactions.sort((a, b) => a.date.compareTo(b.date));
    DateTime initialDate = transactions.first.date;
    List<_CashFlow> cashFlows = transactions
        .map((transaction) => _CashFlow(
            amount: -transaction.amount,
            years: transaction.date.difference(initialDate).inDays / 365))
        .toList();

    cashFlows.add(_CashFlow(
        amount: finalValue,
        years: finalDate.difference(initialDate).inDays / 365));

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
    throw Exception('IRR did not converge');
  }
}

class _CashFlow {
  final double amount;
  final double years;

  _CashFlow({required this.amount, required this.years});
}

class Transaction {
  final double amount;
  final DateTime date;

  Transaction({required this.amount, required this.date});
}
