import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/create_investment_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/custom/currency_text_input_formatter.dart';
import 'package:wealth_wave/ui/custom/date_text_input_formatter.dart';
import 'package:wealth_wave/ui/custom/decimal_text_input_formatter.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showCreateInvestmentDialog(
    {required final BuildContext context, final int? investmentIdToUpdate}) {
  return showDialog(
      context: context,
      builder: (context) =>
          _CreateInvestmentDialog(investmentIdToUpdate: investmentIdToUpdate));
}

class _CreateInvestmentDialog extends StatefulWidget {
  final int? investmentIdToUpdate;

  const _CreateInvestmentDialog({this.investmentIdToUpdate});

  @override
  State<_CreateInvestmentDialog> createState() => _CreateInvestmentPage();
}

class _CreateInvestmentPage extends PageState<CreateInvestmentViewState,
    _CreateInvestmentDialog, CreateInvestmentPresenter> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _irrController = TextEditingController();
  final _valueController = TextEditingController();
  final _investedAmountController = TextEditingController();
  final _investedOnController = TextEditingController();
  final _maturityDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final viewState = presenter.getViewState();
    final irr = viewState.irr;
    final investedAmount = viewState.investedAmount;
    final investedOn = viewState.investedOn;
    final value = viewState.value;
    _nameController.text = viewState.name;
    _descriptionController.text = viewState.description;
    _irrController.text = irr != null ? formatDecimal(irr) : '';
    _investedAmountController.text =
        investedAmount != null ? formatToCurrency(investedAmount) : '';
    _investedOnController.text =
        investedOn != null ? formatDate(investedOn) : '';
    _valueController.text = value != null ? formatToCurrency(value) : '';
    _maturityDateController.text = viewState.maturityDate != null
        ? formatDate(viewState.maturityDate!)
        : '';

    int? investmentIdToUpdate = widget.investmentIdToUpdate;
    if (investmentIdToUpdate != null) {
      presenter.fetchInvestment(id: investmentIdToUpdate);
    }

    _nameController.addListener(() {
      presenter.nameChanged(_nameController.text);
    });

    _descriptionController.addListener(() {
      presenter.descriptionChanged(_descriptionController.text);
    });

    _valueController.addListener(() {
      presenter.valueChanged(parseCurrency(_valueController.text));
    });

    _irrController.addListener(() {
      presenter.irrChanged(double.tryParse(_irrController.text));
    });

    _maturityDateController.addListener(() {
      presenter.maturityDateChanged(parseDate(_maturityDateController.text));
    });

    _investedOnController.addListener(() {
      presenter.onInvestmentOnChanged(parseDate(_investedOnController.text));
    });

    _investedAmountController.addListener(() {
      presenter.onInvestmentAmountChanged(
          parseCurrency(_investedAmountController.text));
    });

    presenter.getBaskets();
  }

  @override
  Widget buildWidget(BuildContext context, CreateInvestmentViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onInvestmentCreated?.consume((_) {
        if (widget.investmentIdToUpdate == null) {
          toastification.show(
              context: context,
              title: const Text(
                  'Investment Created. Add Transactions on the created investment to see IRR'));
        }
        Navigator.of(context).pop();
      });

      snapshot.onInvestmentFetched?.consume((_) {
        final value = snapshot.value;
        final irr = snapshot.irr;
        final investedAmount = snapshot.investedAmount;
        final investedOn = snapshot.investedOn;
        _nameController.text = snapshot.name;
        _descriptionController.text = snapshot.description;
        _irrController.text = irr != null ? formatDecimal(irr) : '';
        _valueController.text = value != null ? formatToCurrency(value) : '';
        _investedAmountController.text =
            investedAmount != null ? formatToCurrency(investedAmount) : '';
        _maturityDateController.text = snapshot.maturityDate != null
            ? formatDate(snapshot.maturityDate!)
            : '';
        _investedOnController.text =
            investedOn != null ? formatDate(investedOn) : '';
      });

      snapshot.onIRRCleared?.consume((_) {
        _irrController.text = '';
      });

      snapshot.onValueCleared?.consume((_) {
        _valueController.text = '';
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
                labelText: 'Name*', border: OutlineInputBorder()),
          ),
          const SizedBox(height: AppDimen.defaultPadding),
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
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(AppDimen.defaultPadding)),
              child: Padding(
                padding: const EdgeInsets.all(AppDimen.minPadding),
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _investedAmountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CurrencyTextInputFormatter()],
                      decoration: const InputDecoration(
                          labelText: 'Invested Amount',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: AppDimen.defaultPadding),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _investedOnController,
                      inputFormatters: [DateTextInputFormatter()],
                      decoration: const InputDecoration(
                          labelText: 'Date (DD/MM/YYYY)',
                          border: OutlineInputBorder()),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: AppDimen.defaultPadding),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(AppDimen.defaultPadding)),
              child: Padding(
                padding: const EdgeInsets.all(AppDimen.minPadding),
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _valueController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CurrencyTextInputFormatter()],
                      decoration: const InputDecoration(
                          labelText: 'Current Value',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: AppDimen.minPadding),
                    const Text('Or'),
                    const SizedBox(height: AppDimen.minPadding),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _irrController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2)
                      ],
                      decoration: const InputDecoration(
                          labelText: 'IRR %', border: OutlineInputBorder()),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: AppDimen.defaultPadding),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _maturityDateController,
            inputFormatters: [DateTextInputFormatter()],
            decoration: const InputDecoration(
                labelText: 'Maturity Date', border: OutlineInputBorder()),
          ),
          const SizedBox(height: AppDimen.minPadding),
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
                        idToUpdate: widget.investmentIdToUpdate);
                  }
                : null,
            child: widget.investmentIdToUpdate != null
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
