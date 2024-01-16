import 'package:wealth_wave/domain/models/transaction.dart';

class Payment {
  final double amount;
  final DateTime createdOn;

  Payment({
    required this.amount,
    required this.createdOn,
  });

  static Payment from({required final Transaction transaction}) {
    return Payment(
        amount: transaction.amount, createdOn: transaction.createdOn);
  }
}
