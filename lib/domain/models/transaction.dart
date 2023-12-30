import 'package:wealth_wave/api/db/app_database.dart';

class Transaction {
  final int id;
  final double amount;
  final DateTime createdOn;

  Transaction(
      {required this.id, required this.amount, required this.createdOn});

  static Transaction from({required final TransactionDO transaction}) {
    return Transaction(
        id: transaction.id,
        amount: transaction.amount,
        createdOn: transaction.amountInvestedOn);
  }
}
