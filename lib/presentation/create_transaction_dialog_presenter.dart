import 'package:intl/intl.dart';
import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';

class CreateTransactionDialogPresenter
    extends Presenter<CreateTransactionPageViewState> {
  final InvestmentApi _investmentApi;

  CreateTransactionDialogPresenter(
      {final InvestmentApi? investmentApi, final BasketApi? basketApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        super(CreateTransactionPageViewState());

  void createTransaction(
      {required final int investmentId, final int? transactionIdToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final amount = viewState.amount;
    final investedDate = viewState.getInvestedDate();

    if (transactionIdToUpdate != null) {
      _investmentApi
          .updateTransaction(
              id: transactionIdToUpdate,
              investmentId: investmentId,
              amount: amount,
              date: investedDate)
          .then((_) => updateViewState((viewState) =>
              viewState.onTransactionCreated = SingleEvent(null)));
    } else {
      _investmentApi
          .createTransaction(
              investmentId: investmentId, amount: amount, date: investedDate)
          .then((_) => updateViewState((viewState) =>
              viewState.onTransactionCreated = SingleEvent(null)));
    }
  }

  void onAmountChanged(String text) {
    updateViewState(
        (viewState) => viewState.amount = double.tryParse(text) ?? 0);
  }

  void transactionDateChanged(String date) {
    updateViewState((viewState) => viewState.investedDate = date);
  }

  void setTransaction(InvestmentTransaction transactionToUpdate) {
    updateViewState((viewState) {
      viewState.amount = transactionToUpdate.amount;
      viewState.investedDate =
          DateFormat('dd-MM-yyyy').format(transactionToUpdate.amountInvestedOn);
    });
  }
}

class CreateTransactionPageViewState {
  double amount = 0.0;
  String investedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  SingleEvent<void>? onTransactionCreated;

  bool isValid() {
    return amount > 0 && _isDateValid();
  }

  DateTime getInvestedDate() {
    return DateFormat('dd-MM-yyyy').parse(investedDate);
  }

  bool _isDateValid() {
    try {
      DateFormat('dd-MM-yyyy').parse(investedDate);
      return true;
    } catch (e) {
      return false;
    }
  }
}
