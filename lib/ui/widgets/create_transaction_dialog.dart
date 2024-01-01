import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/create_transaction_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showCreateTransactionDialog(
    {required final BuildContext context,
    required final int investmentId,
    final TransactionDO? transactionToUpdate}) {
  return showDialog(
      context: context,
      builder: (context) => _CreateTransactionDialog(
            transactionToUpdate: transactionToUpdate,
            investmentId: investmentId,
          ));
}

class _CreateTransactionDialog extends StatefulWidget {
  final TransactionDO? transactionToUpdate;
  final int investmentId;

  const _CreateTransactionDialog(
      {this.transactionToUpdate, required this.investmentId});

  @override
  State<_CreateTransactionDialog> createState() => _CreateTransactionPage();
}

class _CreateTransactionPage extends PageState<CreateTransactionViewState,
    _CreateTransactionDialog, CreateTransactionPresenter> {
  final _valueController = TextEditingController();
  final _valueUpdatedDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    TransactionDO? transactionToUpdate = widget.transactionToUpdate;
    if (transactionToUpdate != null) {
      _valueController.text = transactionToUpdate.amount.toString();
      _valueUpdatedDateController.text =
          formatDate(transactionToUpdate.amountInvestedOn);
      presenter.setTransaction(transactionToUpdate);
    } else {
      _valueUpdatedDateController.text =
         formatDate(DateTime.now());
    }

    _valueController.addListener(() {
      presenter.onAmountChanged(_valueController.text);
    });

    _valueUpdatedDateController.addListener(() {
      presenter.transactionDateChanged(_valueUpdatedDateController.text);
    });
  }

  @override
  Widget buildWidget(
      BuildContext context, CreateTransactionViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onTransactionCreated?.consume((_) {
        Navigator.of(context).pop();
      });
    });

    return AlertDialog(
        title: Text('Create Investment',
            style: Theme.of(context).textTheme.titleMedium),
        actions: [
          ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              }),
          ElevatedButton(
            onPressed: snapshot.isValid()
                ? () {
                    presenter.createTransaction(
                        investmentId: widget.investmentId,
                        transactionIdToUpdate: widget.transactionToUpdate?.id);
                  }
                : null,
            child: widget.transactionToUpdate != null
                ? const Text('Update')
                : const Text('Create'),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _valueController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.minPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _valueUpdatedDateController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[^0-9\-]'))
              ],
              decoration: const InputDecoration(
                  labelText: 'Date (DD-MM-YYYY)', border: OutlineInputBorder()),
            ),
          ]),
        ));
  }

  @override
  CreateTransactionPresenter initializePresenter() {
    return CreateTransactionPresenter();
  }
}
