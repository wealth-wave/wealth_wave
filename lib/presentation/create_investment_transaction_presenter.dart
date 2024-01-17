import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/utils/ui_utils.dart';
import 'package:wealth_wave/utils/utils.dart';

class CreateInvestmentTransactionPresenter
    extends Presenter<CreateTransactionViewState> {
  final Investment _investment;

  CreateInvestmentTransactionPresenter({required final Investment investment})
      : _investment = investment,
        super(CreateTransactionViewState());

  void createTransaction({final int? transactionIdToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final description = viewState.description;
    final amount = viewState.amount;
    final investedDate = viewState.getInvestedDate();

    if (transactionIdToUpdate != null) {
      _investment
          .updateTransaction(
              transactionId: transactionIdToUpdate,
              description: description,
              amount: amount,
              createdOn: investedDate)
          .then((_) => updateViewState((viewState) =>
              viewState.onTransactionCreated = SingleEvent(null)));
    } else {
      _investment
          .createTransaction(
              description: description, amount: amount, createdOn: investedDate)
          .then((_) => updateViewState((viewState) =>
              viewState.onTransactionCreated = SingleEvent(null)));
    }
  }

  void onDescriptionChanged(String text) {
    updateViewState((viewState) => viewState.description = text);
  }

  void onAmountChanged(String text) {
    updateViewState(
        (viewState) => viewState.amount = double.tryParse(text) ?? 0);
  }

  void transactionDateChanged(String date) {
    updateViewState((viewState) => viewState.investedDate = date);
  }

  void setTransaction(TransactionDO transactionToUpdate) {
    updateViewState((viewState) {
      viewState.amount = transactionToUpdate.amount;
      viewState.investedDate = formatDate(transactionToUpdate.createdOn);
    });
  }
}

class CreateTransactionViewState {
  String? description;
  double amount = 0.0;
  String investedDate = formatDate(DateTime.now());
  SingleEvent<void>? onTransactionCreated;

  bool isValid() {
    return amount > 0 && isValidDate(investedDate);
  }

  DateTime getInvestedDate() {
    return parseDate(investedDate);
  }
}
