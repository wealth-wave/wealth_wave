import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/transaction.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class InvestmentTransactionsPresenter extends Presenter<TransactionsViewState> {
  final int _investmentId;
  final InvestmentService _investmentService;

  InvestmentTransactionsPresenter(
      {required final int investmentId,
      final InvestmentService? investmentService})
      : _investmentId = investmentId,
        _investmentService = investmentService ?? InvestmentService(),
        super(TransactionsViewState());

  void getTransactions() {
    _investmentService
        .getBy(id: _investmentId)
        .then((investment) => investment.getTransactions())
        .then((transactions) => Future.wait(transactions.map(
            (transaction) => TransactionVO.from(transaction: transaction))))
        .then((transactions) => updateViewState((viewState) {
              viewState.transactions = transactions;
            }));
  }

  void deleteTransaction({required final int id}) {
    _investmentService
        .getBy(id: _investmentId)
        .then((investment) => investment.deleteTransaction(id: id))
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
  final DateTime createdOn;

  TransactionVO(
      {required this.id,
      required this.investmentId,
      required this.sipId,
      required this.description,
      required this.amount,
      required this.createdOn});

  static Future<TransactionVO> from(
      {required final Transaction transaction}) async {
    return TransactionVO(
        id: transaction.id,
        investmentId: transaction.investmentId,
        sipId: transaction.sipId,
        description: transaction.description,
        amount: transaction.amount,
        createdOn: transaction.createdOn);
  }
}
