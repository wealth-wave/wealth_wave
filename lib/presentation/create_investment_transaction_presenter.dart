import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/transaction.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/domain/services/transaction_service.dart';

class CreateInvestmentTransactionPresenter
    extends Presenter<CreateTransactionViewState> {
  final int _investmentId;
  final InvestmentService _investmentService;
  final TransactionService _transactionService;

  CreateInvestmentTransactionPresenter(
      {required final int investmentId,
      final InvestmentService? investmentService,
      final TransactionService? transactionService})
      : _investmentId = investmentId,
        _investmentService = investmentService ?? InvestmentService(),
        _transactionService = transactionService ?? TransactionService(),
        super(CreateTransactionViewState());

  void createTransaction({final int? idToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String description = viewState.description;
    final double amount = viewState.amount;
    final DateTime investedDate = viewState.investedDate;

    if (idToUpdate != null) {
      _transactionService
          .updateTransaction(
              id: idToUpdate,
              investmentId: _investmentId,
              description: description,
              amount: amount,
              createdOn: investedDate)
          .then((_) => updateViewState((viewState) =>
              viewState.onTransactionCreated = SingleEvent(null)));
    } else {
      _transactionService
          .createTransaction(
              investmentId: _investmentId,
              description: description,
              amount: amount,
              createdOn: investedDate)
          .then((_) => updateViewState((viewState) =>
              viewState.onTransactionCreated = SingleEvent(null)));
    }
  }

  void onDescriptionChanged(String text) {
    updateViewState((viewState) => viewState.description = text);
  }

  void onAmountChanged(double value) {
    updateViewState((viewState) => viewState.amount = value);
  }

  void transactionDateChanged(DateTime date) {
    updateViewState((viewState) => viewState.investedDate = date);
  }

  void _setTransaction(Transaction transactionToUpdate) {
    updateViewState((viewState) {
      viewState.amount = transactionToUpdate.amount;
      viewState.investedDate = transactionToUpdate.createdOn;
      viewState.description = transactionToUpdate.description ?? '';
      viewState.onTransactionLoaded = SingleEvent(null);
    });
  }

  void fetchTransaction({required int id}) {
    _transactionService
        .getById(id: id)
        .then((transaction) => _setTransaction(transaction));
  }
}

class CreateTransactionViewState {
  String description = '';
  double amount = 0;
  DateTime investedDate = DateTime.now();
  SingleEvent<void>? onTransactionCreated;
  SingleEvent<void>? onTransactionLoaded;

  bool isValid() {
    return amount > 0;
  }
}
