import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';

class CreateTransactionDialogPresenter
    extends Presenter<CreateTransactionPageViewState> {
  final InvestmentApi _investmentApi;
  final int investmentId;

  CreateTransactionDialogPresenter(this.investmentId,
      {final InvestmentApi? investmentApi, final BasketApi? basketApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        super(CreateTransactionPageViewState(investmentId));

  void createTransaction() {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final investmentId = viewState.investmentId;
    final amount = viewState.amount;
    final investedDate = viewState.investedDate;

    _investmentApi
        .createTransaction(
            investmentId: investmentId, amount: amount, date: investedDate)
        .then((_) => updateViewState(
            (viewState) => viewState.onTransactionCreated = SingleEvent(null)));
  }

  void onAmountChanged(String text) {
    updateViewState(
        (viewState) => viewState.amount = double.tryParse(text) ?? 0);
  }

  void transactionDateChanged(DateTime date) {
    updateViewState((viewState) => viewState.investedDate = date);
  }

  void setTransaction(InvestmentTransaction transactionToUpdate) {
    updateViewState((viewState) {
      viewState.amount = transactionToUpdate.amount;
      viewState.investedDate = transactionToUpdate.amountInvestedOn;
    });
  }
}

class CreateTransactionPageViewState {
  final int investmentId;
  double amount = 0.0;
  DateTime investedDate = DateTime.now();
  SingleEvent<void>? onTransactionCreated;

  CreateTransactionPageViewState(this.investmentId);

  bool isValid() {
    return amount > 0;
  }
}
