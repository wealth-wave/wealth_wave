import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class ViewTransactionsDialogPresenter
    extends Presenter<ViewTransactionsPageViewState> {
  final InvestmentApi _investmentApi;
  final int investmentId;

  ViewTransactionsDialogPresenter(this.investmentId,
      {final InvestmentApi? investmentApi, final BasketApi? basketApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        super(ViewTransactionsPageViewState(investmentId: investmentId));

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

class ViewTransactionsPageViewState {
  final int investmentId;
  List<InvestmentTransaction> transactions = [];

  ViewTransactionsPageViewState({required this.investmentId});
}
