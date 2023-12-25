import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/create_goal_dialog_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';

Future<void> showCreateGoalDialog(
    {required final BuildContext context, final Goal? goal}) {
  return showDialog(
      context: context,
      builder: (context) => _CreateGoalDialog(goalToUpdate: goal));
}

class _CreateGoalDialog extends StatefulWidget {
  final Goal? goalToUpdate;

  const _CreateGoalDialog({super.key, this.goalToUpdate});

  @override
  State<_CreateGoalDialog> createState() => _CreateGoalPage();
}

class _CreateGoalPage extends PageState<CreateGoalPageViewState,
    _CreateGoalDialog, CreateGoalDialogPresenter> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _currentDateController = TextEditingController();
  final _inflationController = TextEditingController();
  final _targetDateController = TextEditingController();
  final _targetAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Goal? goalToUpdate = widget.goalToUpdate;
    if (goalToUpdate != null) {
      _nameController.text = goalToUpdate.name;
      _amountController.text = goalToUpdate.amount.toString();
      _currentDateController.text =
          DateFormat('dd-MM-yyyy').format(goalToUpdate.date);
      _targetDateController.text =
          DateFormat('dd-MM-yyyy').format(goalToUpdate.targetDate);
      _inflationController.text = goalToUpdate.inflation.toString();

      presenter.setGoal(goalToUpdate);
    }

    _nameController.addListener(() {
      presenter.nameChanged(_nameController.text);
    });

    _amountController.addListener(() {
      presenter.amountChanged(_amountController.text);
    });

    _inflationController.addListener(() {
      presenter
          .inflationChanged(double.tryParse(_inflationController.text) ?? 0);
    });

    _currentDateController.addListener(() {
      presenter.dateChanged(
          DateFormat('dd-MM-yyyy').parse(_currentDateController.text));
    });

    _targetDateController.addListener(() {
      presenter.targetDateChanged(
          DateFormat('dd-MM-yyyy').parse(_targetDateController.text));
    });
  }

  @override
  Widget buildWidget(BuildContext context, CreateGoalPageViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onGoalCreated?.consume((_) {
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
                      Text('Create Basket',
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
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'Amount'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppDimen.minPadding),
                        child: TextFormField(
                          controller: _currentDateController,
                          decoration: const InputDecoration(
                              hintText: 'Date (DD-MM-YYYY)'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppDimen.minPadding),
                        child: TextFormField(
                          controller: _targetDateController,
                          decoration: const InputDecoration(
                              hintText: 'Target Date (DD-MM-YYYY)'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppDimen.minPadding),
                        child: TextFormField(
                          controller: _inflationController,
                          decoration: const InputDecoration(
                              hintText: 'Inflation (0 - 100)'),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(AppDimen.minPadding),
                          child: Text(NumberFormat('###.##')
                              .format(snapshot.getTargetAmount()))),
                      Padding(
                        padding: const EdgeInsets.all(AppDimen.minPadding),
                        child: DropdownButtonFormField<GoalImportance>(
                          hint: const Text('Importance'),
                          value: snapshot.importance,
                          onChanged: (value) {
                            if (value != null) {
                              presenter.importanceChanged(value);
                            }
                          },
                          items: const [
                            DropdownMenuItem(
                              value: GoalImportance.high,
                              child: Text('High'),
                            ),
                            DropdownMenuItem(
                              value: GoalImportance.medium,
                              child: Text('Medium'),
                            ),
                            DropdownMenuItem(
                              value: GoalImportance.low,
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
                                  presenter.createGoal();
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
  CreateGoalDialogPresenter initializePresenter() {
    return CreateGoalDialogPresenter();
  }
}
