import 'package:flutter/material.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/presentation/goals_page_presenter.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPage();
}

class _GoalsPage
    extends PageState<GoalsPageViewState, GoalsPage, GoalsPagePresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchGoals();
  }

  @override
  Widget buildWidget(BuildContext context, GoalsPageViewState snapshot) {
    List<Goal> goals = snapshot.goals;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          Goal goal = goals[index];
          return Card(
              child: ListTile(
            title: Text(goal.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showCreateGoalDialog(context).then((value) {
                      if (value != null && value) {
                        presenter.updateGoal(
                            id: goal.id,
                            name: _nameFieldController.text,
                            targetAmount:
                                double.parse(_amountFieldController.text),
                            targetDate:
                                DateTime.parse(_targetDateFieldController.text),
                            inflation:
                                double.parse(_inflationFieldController.text),
                            importance: _importanceFieldController.text
                                as GoalImportance);
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    presenter.deleteGoal(id: goal.id);
                  },
                ),
              ],
            ),
          ));
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateGoalDialog(context).then((value) {
            if (value != null && value) {
              presenter.createGoal(
                  name: _nameFieldController.text,
                  targetAmount: double.parse(_amountFieldController.text),
                  targetDate: DateTime.parse(_targetDateFieldController.text),
                  inflation: double.parse(_inflationFieldController.text),
                  importance:
                      _importanceFieldController.text as GoalImportance);
            }
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  GoalsPagePresenter initializePresenter() {
    return GoalsPagePresenter();
  }

  final _nameFieldController = TextEditingController();
  final _amountFieldController = TextEditingController();
  final _inflationFieldController = TextEditingController();
  final _targetDateFieldController = TextEditingController();
  final _importanceFieldController = TextEditingController();

  Future<bool?> _showCreateGoalDialog(BuildContext context,
      {Goal? goal}) async {
    if (goal != null) {
      _nameFieldController.text = goal.name;
      _inflationFieldController.text = goal.inflation.toString();
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Create Goal'),
            content: Row(
              children: [
                TextField(
                  controller: _nameFieldController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                TextField(
                  controller: _amountFieldController,
                  decoration: const InputDecoration(hintText: "Amount"),
                ),
                TextField(
                  controller: _inflationFieldController,
                  decoration: const InputDecoration(hintText: "Inflation"),
                ),
                TextField(
                  controller: _targetDateFieldController,
                  decoration: const InputDecoration(hintText: "Target Date"),
                ),
                TextField(
                  controller: _importanceFieldController,
                  decoration: const InputDecoration(hintText: "Importance"),
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  }),
              ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }),
            ],
          );
        });
  }
}
