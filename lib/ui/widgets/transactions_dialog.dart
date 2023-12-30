import 'package:flutter/material.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/transactions_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_transaction_dialog.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showTransactionsDialog(
    {required final BuildContext context, required final int investmentId}) {
  return showDialog(
      context: context,
      builder: (context) => _TransactionsDialog(
            investmentId: investmentId,
          ));
}

class _TransactionsDialog extends StatefulWidget {
  final int investmentId;

  const _TransactionsDialog({required this.investmentId});

  @override
  State<_TransactionsDialog> createState() => _TransactionPage();
}

class _TransactionPage extends PageState<TransactionsViewState,
    _TransactionsDialog, TransactionsPresenter> {
  @override
  void initState() {
    super.initState();

    presenter.getTransactions(investmentId: widget.investmentId);
  }

  @override
  Widget buildWidget(BuildContext context, TransactionsViewState snapshot) {
    return AlertDialog(
      title: const Text('Transactions'),
      content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.transactions.length,
            itemBuilder: (context, index) {
              TransactionDO transaction = snapshot.transactions[index];
              return ListTile(
                title: Text(
                    'Amount: ${transaction.amount.toString()} \nDate: ${formatDate(transaction.amountInvestedOn)}'),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
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
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      presenter.deleteTransaction(id: transaction.id);
                    },
                  )
                ]),
              );
            },
          )),
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
  TransactionsPresenter initializePresenter() {
    return TransactionsPresenter(widget.investmentId);
  }
}
