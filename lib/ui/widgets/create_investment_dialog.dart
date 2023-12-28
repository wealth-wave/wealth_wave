import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/create_investment_dialog_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';

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

class _CreateInvestmentPage extends PageState<CreateInvestmentPageViewState,
    _CreateInvestmentDialog, CreateInvestmentDialogPresenter> {
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _valueUpdatedDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Investment? investmentToUpdate = widget.investmentToUpdate;
    if (investmentToUpdate != null) {
      _nameController.text = investmentToUpdate.name;
      _valueController.text = investmentToUpdate.value.toString();
      _valueUpdatedDateController.text =
          DateFormat('dd-MM-yyyy').format(investmentToUpdate.valueUpdatedOn);
      presenter.setInvestment(investmentToUpdate);
    }

    _nameController.addListener(() {
      presenter.nameChanged(_nameController.text);
    });

    _valueController.addListener(() {
      presenter.valueChanged(_valueController.text);
    });

    _valueUpdatedDateController.addListener(() {
      presenter.valueUpdatedDateChanged(
          DateFormat('dd-MM-yyyy').parse(_valueUpdatedDateController.text));
    });

    presenter.getBaskets();
  }

  @override
  Widget buildWidget(
      BuildContext context, CreateInvestmentPageViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onInvestmentCreated?.consume((_) {
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
                      Text('Create Investment',
                          style: Theme.of(context).textTheme.headlineMedium),
                      Padding(
                        padding: const EdgeInsets.all(AppDimen.minPadding),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: _nameController,
                          decoration: const InputDecoration(hintText: 'Name'),
                        ),
                      ),
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
                      Padding(
                        padding: const EdgeInsets.all(AppDimen.minPadding),
                        child: DropdownButtonFormField<int>(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppDimen.minPadding),
                        child: DropdownButtonFormField<RiskLevel>(
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
                        ),
                      ),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: snapshot.isValid()
                              ? () {
                                  presenter.createInvestment();
                                }
                              : null,
                          child: const Text('Create'),
                        ),
                      ]),
                    ],
                  ),
                )))));
  }

  @override
  CreateInvestmentDialogPresenter initializePresenter() {
    return CreateInvestmentDialogPresenter();
  }
}
