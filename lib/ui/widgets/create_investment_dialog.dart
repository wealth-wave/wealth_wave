import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/presentation/create_investment_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showCreateInvestmentDialog(
    {required final BuildContext context,
    final Investment? investmentToUpdate}) {
  return showDialog(
      context: context,
      builder: (context) =>
          _CreateInvestmentDialog(investmentToUpdate: investmentToUpdate));
}

class _CreateInvestmentDialog extends StatefulWidget {
  final Investment? investmentToUpdate;

  const _CreateInvestmentDialog({this.investmentToUpdate});

  @override
  State<_CreateInvestmentDialog> createState() => _CreateInvestmentPage();
}

class _CreateInvestmentPage extends PageState<CreateInvestmentViewState,
    _CreateInvestmentDialog, CreateInvestmentPresenter> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _valueUpdatedDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Investment? investmentToUpdate = widget.investmentToUpdate;
    if (investmentToUpdate != null) {
      _nameController.text = investmentToUpdate.name;
      _descriptionController.text = investmentToUpdate.description ?? '';
      _valueController.text = investmentToUpdate.value.toString();
      _valueUpdatedDateController.text =
          formatDate(investmentToUpdate.valueUpdatedOn);
      presenter.setInvestment(investmentToUpdate);
    } else {
      _valueUpdatedDateController.text = formatDate(DateTime.now());
    }

    _nameController.addListener(() {
      presenter.nameChanged(_nameController.text);
    });

    _descriptionController.addListener(() {
      presenter.descriptionChanged(_descriptionController.text);
    });

    _valueController.addListener(() {
      presenter.valueChanged(_valueController.text);
    });

    _valueUpdatedDateController.addListener(() {
      presenter.valueUpdatedDateChanged(_valueUpdatedDateController.text);
    });

    presenter.getBaskets();
  }

  @override
  Widget buildWidget(BuildContext context, CreateInvestmentViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onInvestmentCreated?.consume((_) {
        Navigator.of(context).pop();
      });
    });

    return AlertDialog(
        title: Text('Create Investment',
            style: Theme.of(context).textTheme.titleMedium),
        content: SingleChildScrollView(
            child: Column(children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _nameController,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z0-9\s]'))
            ],
            decoration: const InputDecoration(
                labelText: 'Name', border: OutlineInputBorder()),
          ),
          const SizedBox(height: AppDimen.defaultPadding),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _descriptionController,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z0-9\s]'))
            ],
            decoration: const InputDecoration(
                labelText: 'Desctiption', border: OutlineInputBorder()),
          ),
          const SizedBox(height: AppDimen.defaultPadding),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _valueController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
                labelText: 'Value', border: OutlineInputBorder()),
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
          const SizedBox(height: AppDimen.defaultPadding),
          DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Basket'),
              hint: const Text('Basket'),
              value: snapshot.basketId,
              onChanged: (value) {
                if (value != null) {
                  presenter.baskedIdChanged(value);
                }
              },
              items: snapshot.baskets
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                      ))
                  .toList()),
          const SizedBox(height: AppDimen.defaultPadding),
          DropdownButtonFormField<RiskLevel>(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Risk Level'),
            hint: const Text('Risk Level'),
            value: snapshot.riskLevel,
            onChanged: (value) {
              if (value != null) {
                presenter.riskLevelChanged(value);
              }
            },
            items: const [
              DropdownMenuItem(
                value: RiskLevel.high,
                child: Text('High'),
              ),
              DropdownMenuItem(
                value: RiskLevel.medium,
                child: Text('Medium'),
              ),
              DropdownMenuItem(
                value: RiskLevel.low,
                child: Text('Low'),
              ),
            ],
          )
        ])),
        actions: [
          ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              }),
          ElevatedButton(
            onPressed: snapshot.isValid()
                ? () {
                    presenter.createInvestment(
                        investmentIdToUpdate: widget.investmentToUpdate?.id);
                  }
                : null,
            child: widget.investmentToUpdate != null
                ? const Text('Update')
                : const Text('Create'),
          ),
        ]);
  }

  @override
  CreateInvestmentPresenter initializePresenter() {
    return CreateInvestmentPresenter();
  }
}
