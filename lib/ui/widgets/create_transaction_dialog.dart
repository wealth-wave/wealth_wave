import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/create_investment_transaction_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/custom/currency_text_input_formatter.dart';
import 'package:wealth_wave/ui/custom/date_text_input_formatter.dart';
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
      {final int? transactionIdToUpdate, required final int investmentId})
      : _transactionIdToUpdate = transactionIdToUpdate,
        _investmentId = investmentId;

  @override
  State<_CreateTransactionDialog> createState() => _CreateTransactionPage();
}

class _CreateTransactionPage extends PageState<CreateTransactionViewState,
    _CreateTransactionDialog, CreateInvestmentTransactionPresenter> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _qtyController = TextEditingController();
  final _valueUpdatedDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final viewState = presenter.getViewState();
    _valueController.text = formatToCurrency(viewState.amount);
    _qtyController.text = viewState.qty.toString();
    _descriptionController.text = viewState.description;
    _valueUpdatedDateController.text = formatDate(viewState.investedDate);

    int? transactionIdToUpdate = widget._transactionIdToUpdate;
    if (transactionIdToUpdate != null) {
      presenter.fetchTransaction(id: transactionIdToUpdate);
    }

    _valueController.addListener(() {
      presenter.onAmountChanged(parseCurrency(_valueController.text) ?? 0);
    });

    _qtyController.addListener(() {
      presenter.onQtyChanged(parseCurrency(_qtyController.text) ?? 0);
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
      snapshot.onTransactionLoaded?.consume((_) {
        _descriptionController.text = snapshot.description;
        _valueController.text = formatToCurrency(snapshot.amount);
        _qtyController.text = snapshot.qty.toString();
        _valueUpdatedDateController.text = formatDate(snapshot.investedDate);
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
                        idToUpdate: widget._transactionIdToUpdate);
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
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z0-9\s]'))
              ],
              decoration: const InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _valueController,
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _qtyController,
              decoration: const InputDecoration(
                  labelText: 'Qty', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _valueUpdatedDateController,
              inputFormatters: [DateTextInputFormatter()],
              decoration: const InputDecoration(
                  labelText: 'Date (DD/MM/YYYY)', border: OutlineInputBorder()),
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
