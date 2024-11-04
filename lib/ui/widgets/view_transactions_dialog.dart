import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/presentation/transactions_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
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
    _TransactionsDialog, InvestmentTransactionsPresenter> {
  @override
  void initState() {
    super.initState();

    presenter.getTransactions();
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
              TransactionVO transaction = snapshot.transactions[index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(formatDate(transaction.createdOn)),
                        const Text(' | '),
                        Text(transaction.description ?? ''),
                      ],
                    ),
                    const SizedBox(
                        height: AppDimen.minPadding), // Add some spacing
                    Row(
                      children: [
                        if (transaction.qty != 0) ...[
                          Text('Rate: ${formatToCurrency(transaction.rate)}'),
                          const Text(' x '),
                          Text('${transaction.qty}'),
                          const Text(' = '),
                        ],
                        Text('Amount: ${formatToCurrency(transaction.amount)}'),
                      ],
                    )
                  ],
                ),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showCreateTransactionDialog(
                              context: context,
                              investmentId: widget.investmentId,
                              transactionIdToUpdate: transaction.id)
                          .then((value) => presenter.getTransactions());
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
        OutlinedButton(
          child: const Text('Add Transaction'),
          onPressed: () {
            showCreateTransactionDialog(
                    context: context, investmentId: widget.investmentId)
                .then((value) => presenter.getTransactions());
          },
        ),
      ],
    );
  }

  @override
  InvestmentTransactionsPresenter initializePresenter() {
    return InvestmentTransactionsPresenter(investmentId: widget.investmentId);
  }
}
