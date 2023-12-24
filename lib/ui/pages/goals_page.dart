import 'package:flutter/material.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/presentation/goals_page_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_goal_dialog.dart';

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
                    showCreateGoalDialog(context: context, goal: goal);
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
          showCreateGoalDialog(context: context);
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
}
