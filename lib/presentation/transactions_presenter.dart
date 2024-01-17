import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/transaction.dart';

class InvestmentTransactionsPresenter extends Presenter<TransactionsViewState> {
  final Investment _investment;

  InvestmentTransactionsPresenter({required final Investment investment})
      : _investment = investment,
        super(TransactionsViewState());

  void getTransactions() {
    _investment
        .getTransactions()
        .then((transactions) => updateViewState((viewState) {
              viewState.transactions = transactions;
            }));
  }

  void deleteTransaction({required final Transaction transaction}) {
    _investment
        .deleteTransaction(transaction: transaction)
        .then((_) => getTransactions());
  }
}

class TransactionsViewState {
  List<Transaction> transactions = [];
}
