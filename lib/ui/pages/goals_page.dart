import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/goal_do.dart';
import 'package:wealth_wave/presentation/goals_page_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
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
    List<GoalDO> goals = snapshot.goals;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          GoalDO goal = goals[index];
          return Card(
              margin: const EdgeInsets.all(AppDimen.minPadding),
              child: Padding(
                padding: const EdgeInsets.all(AppDimen.minPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${goal.name}'),
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
                        const Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                                '${goal.taggedInvestments.length} Tagged Investments')),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add))
                      ],
                    ),
                  ],
                ),
              ));
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateGoalDialog(context: context)
              .then((value) => presenter.fetchGoals());
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
