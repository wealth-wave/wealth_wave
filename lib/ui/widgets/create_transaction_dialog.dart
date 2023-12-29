import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/create_transaction_dialog_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';

Future<void> showCreateTransactionDialog(
    {required final BuildContext context,
    required final int investmentId,
    final InvestmentTransaction? transactionToUpdate}) {
  return showDialog(
      context: context,
      builder: (context) => _CreateTransactionDialog(
            transactionToUpdate: transactionToUpdate,
            investmentId: investmentId,
          ));
}

class _CreateTransactionDialog extends StatefulWidget {
  final InvestmentTransaction? transactionToUpdate;
  final int investmentId;

  const _CreateTransactionDialog(
      {this.transactionToUpdate, required this.investmentId});

  @override
  State<_CreateTransactionDialog> createState() => _CreateTransactionPage();
}

class _CreateTransactionPage extends PageState<CreateTransactionPageViewState,
    _CreateTransactionDialog, CreateTransactionDialogPresenter> {
  final _valueController = TextEditingController();
  final _valueUpdatedDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    InvestmentTransaction? transactionToUpdate = widget.transactionToUpdate;
    if (transactionToUpdate != null) {
      _valueController.text = transactionToUpdate.amount.toString();
      _valueUpdatedDateController.text =
          DateFormat('dd-MM-yyyy').format(transactionToUpdate.amountInvestedOn);
      presenter.setTransaction(transactionToUpdate);
    }

    _valueController.addListener(() {
      presenter.onAmountChanged(_valueController.text);
    });

    _valueUpdatedDateController.addListener(() {
      presenter.transactionDateChanged(
          DateFormat('dd-MM-yyyy').parse(_valueUpdatedDateController.text));
    });
  }

  @override
  Widget buildWidget(
      BuildContext context, CreateTransactionPageViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onTransactionCreated?.consume((_) {
        Navigator.of(context).pop();
      });
    });

    return Scaffold(
        body: Center(
            child: SizedBox(
                width: 400,
                child: Card(
                    child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Create Transaction',
                          style: Theme.of(context).textTheme.headlineMedium),
                      Padding(
                        padding: const EdgeInsets.all(AppDimen.minPadding),
                        child: TextFormField(
                          controller: _valueController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'Amount'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppDimen.minPadding),
                        child: TextFormField(
                          controller: _valueUpdatedDateController,
                          decoration: const InputDecoration(
                              hintText: 'Date (DD-MM-YYYY)'),
                        ),
                      ),
                      FilledButton(
                        onPressed: snapshot.isValid()
                            ? () {
                                presenter.createTransaction();
                              }
                            : null,
                        child: const Text('Create'),
                      ),
                    ],
                  ),
                )))));
  }

  @override
  CreateTransactionDialogPresenter initializePresenter() {
    return CreateTransactionDialogPresenter(widget.investmentId);
  }
}
