import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class TransactionsPresenter extends Presenter<TransactionsViewState> {
  final InvestmentApi _investmentApi;
  final int investmentId;

  TransactionsPresenter(this.investmentId,
      {final InvestmentApi? investmentApi, final BasketApi? basketApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        super(TransactionsViewState(investmentId: investmentId));

  void getTransactions({required final int investmentId}) {
    _investmentApi
        .getTransactions(investmentId: investmentId)
        .then((transactions) => updateViewState((viewState) {
              viewState.transactions = transactions;
            }));
  }

  void deleteTransaction({required final int id}) {
    _investmentApi
        .deleteTransaction(id: id)
        .then((_) => getTransactions(investmentId: investmentId));
  }
}

class TransactionsViewState {
  final int investmentId;
  List<TransactionDO> transactions = [];

  TransactionsViewState({required this.investmentId});
}
