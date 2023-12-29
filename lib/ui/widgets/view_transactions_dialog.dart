import 'package:flutter/material.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/view_transactions_dialog_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_transaction_dialog.dart';

Future<void> showViewTransactionsDialog(
    {required final BuildContext context, required final int investmentId}) {
  return showDialog(
      context: context,
      builder: (context) => _ViewTransactionsDialog(
            investmentId: investmentId,
          ));
}

class _ViewTransactionsDialog extends StatefulWidget {
  final int investmentId;

  const _ViewTransactionsDialog({required this.investmentId});

  @override
  State<_ViewTransactionsDialog> createState() => _ViewTransactionPage();
}

class _ViewTransactionPage extends PageState<ViewTransactionsPageViewState,
    _ViewTransactionsDialog, ViewTransactionsDialogPresenter> {
  @override
  void initState() {
    super.initState();

    presenter.getTransactions(investmentId: widget.investmentId);
  }

  @override
  Widget buildWidget(
      BuildContext context, ViewTransactionsPageViewState snapshot) {
    return AlertDialog(
      title: const Text('Transactions'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.transactions.length,
          itemBuilder: (context, index) {
            InvestmentTransaction transaction = snapshot.transactions[index];
            return ListTile(
              title: Text(
                  'Amount: ${transaction.amount.toString()} \nDate: ${transaction.amountInvestedOn.toString()}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showCreateTransactionDialog(
                          context: context,
                          investmentId: widget.investmentId,
                          transactionToUpdate: transaction)
                      .then((value) => presenter.getTransactions(
                          investmentId: widget.investmentId));
                },
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  ViewTransactionsDialogPresenter initializePresenter() {
    return ViewTransactionsDialogPresenter(widget.investmentId);
  }
}
