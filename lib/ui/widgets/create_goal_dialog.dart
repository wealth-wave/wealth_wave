import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/create_goal_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/custom/currency_text_input_formatter.dart';
import 'package:wealth_wave/ui/custom/date_text_input_formatter.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showCreateGoalDialog(
    {required final BuildContext context, final int? goalIdToUpdate}) {
  return showDialog(
      context: context,
      builder: (context) => _CreateGoalDialog(goalIdToUpdate: goalIdToUpdate));
}

class _CreateGoalDialog extends StatefulWidget {
  final int? goalIdToUpdate;

  const _CreateGoalDialog({this.goalIdToUpdate});

  @override
  State<_CreateGoalDialog> createState() => _CreateGoalPage();
}

class _CreateGoalPage extends PageState<CreateGoalViewState, _CreateGoalDialog,
    CreateGoalPresenter> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _currentDateController = TextEditingController();
  final _inflationController = TextEditingController();
  final _targetDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final viewState = presenter.getViewState();
    _nameController.text = viewState.name;
    _descriptionController.text = viewState.description;
    _amountController.text = formatToCurrency(viewState.amount);
    _currentDateController.text = formatDate(viewState.date);
    _targetDateController.text = formatDate(viewState.targetDate);
    _inflationController.text = viewState.inflation.toString();

    int? goalIdToUpdate = widget.goalIdToUpdate;
    if (goalIdToUpdate != null) {
      presenter.fetchGoal(id: goalIdToUpdate);
    }

    _nameController.addListener(() {
      presenter.nameChanged(_nameController.text);
    });

    _descriptionController.addListener(() {
      presenter.descriptionChanged(_descriptionController.text);
    });

    _amountController.addListener(() {
      presenter.amountChanged(parseCurrency(_amountController.text) ?? 0);
    });

    _inflationController.addListener(() {
      presenter
          .inflationChanged(double.tryParse(_inflationController.text) ?? 0);
    });

    _currentDateController.addListener(() {
      presenter.dateChanged(
          parseDate(_currentDateController.text) ?? DateTime.now());
    });

    _targetDateController.addListener(() {
      presenter.targetDateChanged(
          parseDate(_targetDateController.text) ?? DateTime.now());
    });
  }

  @override
  Widget buildWidget(BuildContext context, CreateGoalViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onGoalCreated?.consume((_) {
        Navigator.of(context).pop();
      });

      snapshot.onDataLoaded?.consume((_) {
        _nameController.text = snapshot.name;
        _descriptionController.text = snapshot.description;
        _amountController.text = formatToCurrency(snapshot.amount);
        _currentDateController.text = formatDate(snapshot.date);
        _targetDateController.text = formatDate(snapshot.targetDate);
        _inflationController.text = snapshot.inflation.toString();
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
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
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
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
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
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [CurrencyTextInputFormatter()],
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _currentDateController,
              inputFormatters: [DateTextInputFormatter()],
              decoration: const InputDecoration(
                  labelText: 'Date (DD/MM/YYYY)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _targetDateController,
              inputFormatters: [DateTextInputFormatter()],
              decoration: const InputDecoration(
                  labelText: 'Target Date (DD/MM/YYYY)',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: _inflationController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                  hintText: 'Inflation (0 - 100)',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Target Amount',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 10), // Add some spacing
                Text(
                  formatToCurrency(snapshot.getTargetAmount()),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            DropdownButtonFormField<GoalImportance>(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Importance'),
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
                  presenter.createGoal(goalIdToUpdate: widget.goalIdToUpdate);
                }
              : null,
          child: widget.goalIdToUpdate == null
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
