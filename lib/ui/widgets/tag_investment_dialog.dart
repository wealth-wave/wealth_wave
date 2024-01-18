import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/tag_investment_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';

Future<void> showTagInvestmentDialog({
  required final BuildContext context,
  required final int goalId,
  final int? idToUpdate,
  final int? investmentId,
  final double? sharePercentage,
}) {
  return showDialog(
      context: context,
      builder: (context) => _TagInvestmentDialog(
          idToUpdate: idToUpdate,
          goalId: goalId,
          investmentId: investmentId,
          sharePercentage: sharePercentage));
}

class _TagInvestmentDialog extends StatefulWidget {
  final int goalId;
  final int? idToUpdate;
  final int? investmentId;
  final double? sharePercentage;

  const _TagInvestmentDialog(
      {required this.goalId,
      this.idToUpdate,
      this.investmentId,
      this.sharePercentage});

  @override
  State<_TagInvestmentDialog> createState() => _TagInvestmentState();
}

class _TagInvestmentState extends PageState<TagInvestmentViewState,
    _TagInvestmentDialog, TagInvestmentPresenter> {
  final _valueController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final int? investmentId = widget.investmentId;
    final double? sharePercentage = widget.sharePercentage;

    if (investmentId != null) {
      presenter.onInvestmentSelected(investmentId);
    }
    if (sharePercentage != null) {
      _valueController.text = sharePercentage.toString();
    } else {
      _valueController.text = '100';
    }

    _valueController.addListener(() {
      presenter.onPercentageChanged(_valueController.text);
    });

    presenter.fetchInvesments();
  }

  @override
  Widget buildWidget(BuildContext context, TagInvestmentViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onInvestmentTagged?.consume((_) {
        Navigator.of(context).pop();
      });
    });

    return AlertDialog(
        title: Text('Tag Investment',
            style: Theme.of(context).textTheme.titleMedium),
        content: SingleChildScrollView(
            child: Column(children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _valueController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
                labelText: 'Percentage of', border: OutlineInputBorder()),
          ),
          const SizedBox(height: AppDimen.minPadding),
          DropdownButtonFormField<int>(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text('Investment'),
              value: snapshot.investmentId,
              onChanged: (value) {
                if (value != null) {
                  presenter.onInvestmentSelected(value);
                }
              },
              items: snapshot.investments
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                      ))
                  .toList()),
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
                    presenter.tagInvestment();
                  }
                : null,
            child: widget.idToUpdate != null
                ? const Text('Update')
                : const Text('Create'),
          ),
        ]);
  }

  @override
  TagInvestmentPresenter initializePresenter() {
    return TagInvestmentPresenter(goalId: widget.goalId);
  }
}
