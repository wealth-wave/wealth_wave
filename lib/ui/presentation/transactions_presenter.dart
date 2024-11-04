import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/transaction.dart';
import 'package:wealth_wave/domain/services/transaction_service.dart';

class InvestmentTransactionsPresenter extends Presenter<TransactionsViewState> {
  final int _investmentId;
  final TransactionService _transactionService;

  InvestmentTransactionsPresenter(
      {required final int investmentId,
      final TransactionService? transactionService})
      : _investmentId = investmentId,
        _transactionService = transactionService ?? TransactionService(),
        super(TransactionsViewState());

  void getTransactions() {
    _transactionService
        .getBy(investmentId: _investmentId)
        .then((transactions) => transactions
            .map((transaction) => TransactionVO.from(transaction: transaction))
            .toList())
        .then((transactions) => updateViewState((viewState) {
              viewState.transactions = transactions;
            }));
  }

  void deleteTransaction({required final int id}) {
    _transactionService
        .deleteTransaction(id: id)
        .then((_) => getTransactions());
  }
}

class TransactionsViewState {
  List<TransactionVO> transactions = [];
}

class TransactionVO {
  final int id;
  final int investmentId;
  final int? sipId;
  final String? description;
  final double amount;
  final double qty;
  final DateTime createdOn;

  double get rate => qty != 0 ? amount / qty : 0;

  TransactionVO._(
      {required this.id,
      required this.investmentId,
      required this.sipId,
      required this.description,
      required this.amount,
      required this.qty,
      required this.createdOn});

  factory TransactionVO.from({required final Transaction transaction}) {
    return TransactionVO._(
        id: transaction.id,
        investmentId: transaction.investmentId,
        sipId: transaction.sipId,
        description: transaction.description,
        amount: transaction.amount,
        qty: transaction.qty,
        createdOn: transaction.createdOn);
  }
}
