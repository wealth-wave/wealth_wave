import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/create_goal_page_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/nav_path.dart';

class CreateGoalPage extends StatefulWidget {
  const CreateGoalPage({super.key});

  @override
  State<CreateGoalPage> createState() => _CreateGoalPage();
}

class _CreateGoalPage extends PageState<CreateGoalPageViewState, CreateGoalPage,
    CreateGoalPagePresenter> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _targetDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      presenter.nameChanged(_nameController.text);
    });

    _amountController.addListener(() {
      presenter.amountChanged(_amountController.text);
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
                        controller: _targetDateController,
                        readOnly: true,
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            _targetDateController.text =
                                DateFormat('dd-MM-yyyy').format(date);
                            ;
                            presenter.targetDateChanged(date);
                          }
                        },
                        decoration:
                            const InputDecoration(hintText: 'Target Date'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppDimen.minPadding),
                      child: Slider(
                          label: 'Inflation',
                          min: 0,
                          max: 20,
                          divisions: 20,
                          value: (snapshot.inflation ?? 0),
                          onChanged: (value) {
                            presenter.inflationChanged(value);
                          }),
                    ),
                    Text(
                      "Inflation: ${(snapshot.inflation ?? 0)}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
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
                    FilledButton(
                      onPressed: snapshot.isValid()
                          ? () {
                              presenter.createGoal();
                            }
                          : null,
                      child: const Text('Create'),
                    ),
                  ],
                ),
              )))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NavPath.createGoal);
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  CreateGoalPagePresenter initializePresenter() {
    return CreateGoalPagePresenter();
  }
}
