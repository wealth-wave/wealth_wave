import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/tag_goal_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';

Future<void> showTagGoalDialog({
  required final BuildContext context,
  required final int investmentId,
  final int? goalId,
  final double? sharePercentage,
}) {
  return showDialog(
      context: context,
      builder: (context) => _TagGoalDialog(
          goalId: goalId,
          investmentId: investmentId,
          sharePercentage: sharePercentage));
}

class _TagGoalDialog extends StatefulWidget {
  final int investmentId;
  final int? goalId;
  final double? sharePercentage;

  const _TagGoalDialog(
      {required this.investmentId, this.goalId, this.sharePercentage});

  @override
  State<_TagGoalDialog> createState() => _TagInvestmentState();
}

class _TagInvestmentState
    extends PageState<TagGoalViewState, _TagGoalDialog, TagGoalPresenter> {
  final _valueController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final int? goalId = widget.goalId;
    final double? sharePercentage = widget.sharePercentage;

    if (goalId != null) {
      presenter.onGoalSelected(goalId);
    }
    if (sharePercentage != null) {
      _valueController.text = sharePercentage.toString();
    } else {
      _valueController.text = '100';
    }

    _valueController.addListener(() {
      presenter.onPercentageChanged(_valueController.text);
    });

    presenter.getGoals();
  }

  @override
  Widget buildWidget(BuildContext context, TagGoalViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onGoalTagged?.consume((_) {
        Navigator.of(context).pop();
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
              value: snapshot.investmentId,
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
            child: widget.goalId != null
                ? const Text('Update')
                : const Text('Create'),
          ),
        ]);
  }

  @override
  TagGoalPresenter initializePresenter() {
    return TagGoalPresenter(widget.investmentId);
  }
}
