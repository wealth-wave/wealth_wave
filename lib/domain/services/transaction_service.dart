import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/domain/models/transaction.dart';

class TransactionService {
  final TransactionApi _transactionApi;

  factory TransactionService() {
    return _instance;
  }

  static final TransactionService _instance = TransactionService._();

  TransactionService._({final TransactionApi? transactionApi})
      : _transactionApi = transactionApi ?? TransactionApi();

  Future<Transaction> getBy({required final int id}) async {
    return _transactionApi.getById(id: id).then((transactionDO) {
      return Transaction.from(transactionDO: transactionDO);
    });
  }
}
