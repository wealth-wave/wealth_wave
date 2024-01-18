import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/create_sip_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
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
  State<_CreateSipDialog> createState() => _CreateTransactionPage();
}

class _CreateTransactionPage extends PageState<CreateSipViewState,
    _CreateSipDialog, CreateSipPresenter> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    int? sipIdToUpdate = widget.sipIdToUpdate;
    if (sipIdToUpdate != null) {
      presenter.fetchSip(id: sipIdToUpdate);
    } else {
      _startDateController.text = formatDate(DateTime.now());
    }

    _valueController.addListener(() {
      presenter.onAmountChanged(_valueController.text);
    });

    _descriptionController.addListener(() {
      presenter.onDescriptionChanged(_descriptionController.text);
    });

    _startDateController.addListener(() {
      presenter.startDateChanged(_startDateController.text);
    });
  }

  @override
  Widget buildWidget(BuildContext context, CreateSipViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onSipCreated?.consume((_) {
        Navigator.of(context).pop();
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
                    presenter.createSip(
                        investmentId: widget.investmentId,
                        sipIdToUpdate: widget.sipIdToUpdate);
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
              controller: _startDateController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[^0-9\-]'))
              ],
              decoration: const InputDecoration(
                  labelText: 'Start Date (DD-MM-YYYY)',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _endDateController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[^0-9\-]'))
              ],
              decoration: const InputDecoration(
                  labelText: 'End Date (DD-MM-YYYY)',
                  border: OutlineInputBorder()),
            ),
          ]),
        ));
  }

  @override
  CreateSipPresenter initializePresenter() {
    return CreateSipPresenter(investmentId: widget.investmentId);
  }
}
