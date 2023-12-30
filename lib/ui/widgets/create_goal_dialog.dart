import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/presentation/create_goal_presenter.dart';
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

class _CreateGoalPage extends PageState<CreateGoalViewState, _CreateGoalDialog,
    CreateGoalPresenter> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _currentDateController = TextEditingController();
  final _inflationController = TextEditingController();
  final _targetDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Goal? goalToUpdate = widget.goalToUpdate;
    if (goalToUpdate != null) {
      _nameController.text = goalToUpdate.name;
      _amountController.text = goalToUpdate.amount.toString();
      _currentDateController.text =
          DateFormat('dd-MM-yyyy').format(goalToUpdate.createdDate);
      _targetDateController.text =
          DateFormat('dd-MM-yyyy').format(goalToUpdate.targetDate);
      _inflationController.text = goalToUpdate.inflation.toString();

      presenter.setGoal(goalToUpdate);
    } else {
      _currentDateController.text =
          DateFormat('dd-MM-yyyy').format(DateTime.now());
      _targetDateController.text = DateFormat('dd-MM-yyyy')
          .format(DateTime.now().add(const Duration(days: 365)));
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
  Widget buildWidget(BuildContext context, CreateGoalViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onGoalCreated?.consume((_) {
        Navigator.of(context).pop();
      });
    });

    return AlertDialog(
      title:
          Text('Create Goal', style: Theme.of(context).textTheme.titleMedium),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: _nameController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z0-9\s]'))
              ],
              decoration: const InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.minPadding),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.minPadding),
            TextFormField(
              controller: _currentDateController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[^0-9\-]'))
              ],
              decoration: const InputDecoration(
                  labelText: 'Date (DD-MM-YYYY)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.minPadding),
            TextFormField(
              controller: _targetDateController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'[^0-9\-]'))
              ],
              decoration: const InputDecoration(
                  labelText: 'Target Date (DD-MM-YYYY)',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.minPadding),
            TextFormField(
              controller: _inflationController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  hintText: 'Inflation (0 - 100)',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.minPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Target Amount',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 10), // Add some spacing
                Text(
                  NumberFormat('###.##').format(snapshot.getTargetAmount()),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: AppDimen.minPadding),
            DropdownButtonFormField<GoalImportance>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
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
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: snapshot.isValid()
              ? () {
                  presenter.createGoal(goalIdToUpdate: widget.goalToUpdate?.id);
                }
              : null,
          child: widget.goalToUpdate == null
              ? const Text('Create')
              : const Text('Update'),
        ),
      ],
    );
  }

  @override
  CreateGoalPresenter initializePresenter() {
    return CreateGoalPresenter();
  }
}
