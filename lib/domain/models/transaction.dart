import 'package:wealth_wave/api/db/app_database.dart';

class Transaction {
  final int id;
  final String? description;
  final double amount;
  final DateTime createdOn;

  Transaction(
      {required this.id,
      required this.description,
      required this.amount,
      required this.createdOn});

  static Transaction from({required final TransactionDO transaction}) {
    return Transaction(
        id: transaction.id,
        description: transaction.description,
        amount: transaction.amount,
        createdOn: transaction.amountInvestedOn);
  }
}
