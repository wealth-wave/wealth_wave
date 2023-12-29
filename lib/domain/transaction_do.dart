import 'package:wealth_wave/api/db/app_database.dart';

class TransactionDO {
  final int id;
  final double amount;
  final DateTime createdOn;

  TransactionDO(
      {required this.id, required this.amount, required this.createdOn});

  static TransactionDO from(
      {required final InvestmentTransaction transaction}) {
    return TransactionDO(
        id: transaction.id,
        amount: transaction.amount,
        createdOn: transaction.amountInvestedOn);
  }
}
