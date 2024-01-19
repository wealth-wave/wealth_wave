import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/services/transaction_service.dart';
import 'package:wealth_wave/presentation/create_investment_transaction_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showCreateTransactionDialog(
    {required final BuildContext context,
    required final int investmentId,
    final int? transactionIdToUpdate}) {
  return showDialog(
      context: context,
      builder: (context) => _CreateTransactionDialog(
            transactionIdToUpdate: transactionIdToUpdate,
            investmentId: investmentId,
          ));
}

class _CreateTransactionDialog extends StatefulWidget {
  final int? _transactionIdToUpdate;
  final int _investmentId;

  const _CreateTransactionDialog(
      {final int? transactionIdToUpdate,
      required final int investmentId,
      final TransactionService? transactionService})
      : _transactionIdToUpdate = transactionIdToUpdate,
        _investmentId = investmentId;

  @override
  State<_CreateTransactionDialog> createState() => _CreateTransactionPage();
}

class _CreateTransactionPage extends PageState<CreateTransactionViewState,
    _CreateTransactionDialog, CreateInvestmentTransactionPresenter> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _valueUpdatedDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    int? transactionIdToUpdate = widget._transactionIdToUpdate;
    if (transactionIdToUpdate != null) {
      presenter.fetchTransaction(id: transactionIdToUpdate);
    }

    _valueController.addListener(() {
      presenter.onAmountChanged(double.tryParse(_valueController.text) ?? 0);
    });

    _descriptionController.addListener(() {
      presenter.onDescriptionChanged(_descriptionController.text);
    });

    _valueUpdatedDateController.addListener(() {
      presenter.transactionDateChanged(
          parseDate(_valueUpdatedDateController.text) ?? DateTime.now());
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
        title: Text('Create Transaction',
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
                        transactionIdToUpdate: widget._transactionIdToUpdate);
                  }
                : null,
            child: widget._transactionIdToUpdate != null
                ? const Text('Update')
                : const Text('Create'),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _valueController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
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
  CreateInvestmentTransactionPresenter initializePresenter() {
    return CreateInvestmentTransactionPresenter(
        investmentId: widget._investmentId);
  }
}
