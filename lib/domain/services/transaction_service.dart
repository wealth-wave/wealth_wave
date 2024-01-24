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

  Future<Transaction> createTransaction(
          {required final int investmentId,
          required final String? description,
          required final double amount,
          final int? sipId,
          required final DateTime createdOn}) =>
      _transactionApi
          .create(
              investmentId: investmentId,
              description: description,
              amount: amount,
              sipId: sipId,
              createdOn: createdOn)
          .then((id) => _transactionApi.getById(id: id))
          .then((transactionDO) =>
              Transaction.from(transactionDO: transactionDO));

  Future<Transaction> getById({required final int id}) => _transactionApi
      .getById(id: id)
      .then((transactionDO) => Transaction.from(transactionDO: transactionDO));

  Future<List<Transaction>> getBy({final int? investmentId}) {
    if (investmentId != null) {
      return _transactionApi.getBy(investmentId: investmentId).then(
          (transactions) => transactions
              .map((transactionDO) =>
                  Transaction.from(transactionDO: transactionDO))
              .toList());
    }

    throw Exception("InvestmentId is required");
  }

  Future<Transaction> updateTransaction(
          {required final int investmentId,
          required final int id,
          final int? sipId,
          required final String? description,
          required final double amount,
          required final DateTime createdOn}) =>
      _transactionApi
          .update(
              id: id,
              investmentId: investmentId,
              description: description,
              amount: amount,
              sipId: sipId,
              createdOn: createdOn)
          .then((count) => _transactionApi.getById(id: id))
          .then((transactionDO) =>
              Transaction.from(transactionDO: transactionDO));

  Future<void> deleteTransaction({required final int id}) =>
      _transactionApi.deleteBy(id: id).then((count) => {});
}
