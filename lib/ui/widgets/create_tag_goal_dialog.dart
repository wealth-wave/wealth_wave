import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/tag_goal_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showTagGoalDialog({
  required final BuildContext context,
  required final int investmentId,
  final int? idToUpdate,
}) {
  return showDialog(
      context: context,
      builder: (context) =>
          _TagGoalDialog(idToUpdate: idToUpdate, investmentId: investmentId));
}

class _TagGoalDialog extends StatefulWidget {
  final int investmentId;
  final int? idToUpdate;

  const _TagGoalDialog({required this.investmentId, this.idToUpdate});

  @override
  State<_TagGoalDialog> createState() => _TagInvestmentState();
}

class _TagInvestmentState
    extends PageState<TagGoalViewState, _TagGoalDialog, TagGoalPresenter> {
  final _valueController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final int? idToUpdate = widget.idToUpdate;
    if (idToUpdate != null) {
      presenter.loadTaggedGoal(id: idToUpdate);
    }

    _valueController.addListener(() {
      presenter
          .onPercentageChanged(double.tryParse(_valueController.text) ?? 0);
    });

    presenter.fetchGoals();
  }

  @override
  Widget buildWidget(BuildContext context, TagGoalViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onGoalTagged?.consume((_) {
        Navigator.of(context).pop();
      });
      snapshot.onGoalTagLoaded?.consume((_) {
        _valueController.text = formatDecimal(snapshot.sharePercentage);
      });
    });

    return AlertDialog(
        title: Text('Tag Goal', style: Theme.of(context).textTheme.titleMedium),
        content: SingleChildScrollView(
            child: Column(children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _valueController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
                labelText: 'Percentage to', border: OutlineInputBorder()),
          ),
          const SizedBox(height: AppDimen.minPadding),
          DropdownButtonFormField<int>(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text('Goal'),
              value: snapshot.goalId,
              onChanged: (value) {
                if (value != null) {
                  presenter.onGoalSelected(value);
                }
              },
              items: snapshot.goals
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
                    presenter.tagGoal();
                  }
                : null,
            child: widget.idToUpdate != null
                ? const Text('Update')
                : const Text('Create'),
          ),
        ]);
  }

  @override
  TagGoalPresenter initializePresenter() {
    return TagGoalPresenter(investmentId: widget.investmentId);
  }
}
