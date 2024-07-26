import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wave/contract/frequency.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/presentation/create_sip_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/custom/currency_text_input_formatter.dart';
import 'package:wealth_wave/ui/custom/date_text_input_formatter.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showCreateSipDialog(
    {required final BuildContext context,
    required final int investmentId,
    final int? sipIdToUpdate}) {
  return showDialog(
      context: context,
      builder: (context) => _CreateSipDialog(
            sipIdToUpdate: sipIdToUpdate,
            investmentId: investmentId,
          ));
}

class _CreateSipDialog extends StatefulWidget {
  final int? sipIdToUpdate;
  final int investmentId;

  const _CreateSipDialog({this.sipIdToUpdate, required this.investmentId});

  @override
  State<_CreateSipDialog> createState() => _CreateSipPage();
}

class _CreateSipPage extends PageState<CreateSipViewState,
    _CreateSipDialog, CreateSipPresenter> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final viewState = presenter.getViewState();
    _valueController.text = formatToCurrency(viewState.amount);
    _descriptionController.text = viewState.description;
    _startDateController.text = formatDate(viewState.startDate);
    _endDateController.text =
        viewState.endDate != null ? formatDate(viewState.endDate!) : '';

    int? sipIdToUpdate = widget.sipIdToUpdate;
    if (sipIdToUpdate != null) {
      presenter.fetchSip(id: sipIdToUpdate);
    }

    _valueController.addListener(() {
      presenter.onAmountChanged(parseCurrency(_valueController.text) ?? 0);
    });

    _descriptionController.addListener(() {
      presenter.onDescriptionChanged(_descriptionController.text);
    });

    _startDateController.addListener(() {
      presenter.startDateChanged(
          parseDate(_startDateController.text) ?? DateTime.now());
    });

    _endDateController.addListener(() {
      presenter.endDateChanged(
          parseDate(_endDateController.text) ?? DateTime.now());
    });
  }

  @override
  Widget buildWidget(BuildContext context, CreateSipViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onSipCreated?.consume((_) {
        Navigator.of(context).pop();
      });
      snapshot.onSipLoaded?.consume((_) {
        _valueController.text = formatToCurrency(snapshot.amount);
        _descriptionController.text = snapshot.description;
        _startDateController.text = formatDate(snapshot.startDate);
        _endDateController.text =
            snapshot.endDate != null ? formatDate(snapshot.endDate!) : '';
      });
    });

    return AlertDialog(
        title:
            Text('Create Sip', style: Theme.of(context).textTheme.titleMedium),
        actions: [
          ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              }),
          ElevatedButton(
            onPressed: snapshot.isValid()
                ? () {
                    presenter.createSip(idToUpdate: widget.sipIdToUpdate);
                  }
                : null,
            child: widget.sipIdToUpdate != null
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
              inputFormatters: [CurrencyTextInputFormatter()],
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _startDateController,
              inputFormatters: [DateTextInputFormatter()],
              decoration: const InputDecoration(
                  labelText: 'Start Date (DD-MM-YYYY)',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _endDateController,
              inputFormatters: [DateTextInputFormatter()],
              decoration: const InputDecoration(
                  labelText: 'End Date (DD-MM-YYYY)',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            DropdownButtonFormField<Frequency>(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Frequency'),
              hint: const Text('Frequency'),
              value: snapshot.frequency,
              onChanged: (value) {
                if (value != null) {
                  presenter.onFrequencyChanged(value);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: Frequency.daily,
                  child: Text('Daily'),
                ),
                DropdownMenuItem(
                  value: Frequency.weekly,
                  child: Text('Weekly'),
                ),
                DropdownMenuItem(
                  value: Frequency.biweekly,
                  child: Text('Bi Weekly'),
                ),
                DropdownMenuItem(
                  value: Frequency.monthly,
                  child: Text('Monthly'),
                ),
                DropdownMenuItem(
                  value: Frequency.quarterly,
                  child: Text('Quarterly'),
                ),
                DropdownMenuItem(
                  value: Frequency.halfYearly,
                  child: Text('Half Yearly'),
                ),
                DropdownMenuItem(
                  value: Frequency.yearly,
                  child: Text('Yearly'),
                ),
              ],
            ),
          ]),
        ));
  }

  @override
  CreateSipPresenter initializePresenter() {
    return CreateSipPresenter(investmentId: widget.investmentId);
  }
}
