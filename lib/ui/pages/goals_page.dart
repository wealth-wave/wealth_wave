import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/domain/models/goal.dart';
import 'package:wealth_wave/presentation/goals_presenter.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/widgets/create_goal_dialog.dart';
import 'package:wealth_wave/ui/widgets/tag_investment_dialog.dart';
import 'package:wealth_wave/ui/widgets/tagged_investment_dialog.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPage();
}

class _GoalsPage extends PageState<GoalsViewState, GoalsPage, GoalsPresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchGoals();
  }

  @override
  Widget buildWidget(BuildContext context, GoalsViewState snapshot) {
    List<Goal> goals = snapshot.goals;
    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          Goal goal = goals[index];
          return Card(
              margin: const EdgeInsets.all(AppDimen.minPadding),
              child: Padding(
                padding: const EdgeInsets.all(AppDimen.minPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(goal.name),
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
                            onPressed: () {
                              showTaggedInvestmentDialog(
                                  context: context, goalId: goal.id);
                            },
                            child: Text(
                                '${goal.taggedInvestments.length} Tagged Investments')),
                        IconButton(
                            onPressed: () {
                              showTagInvestmentDialog(
                                      context: context, goalId: goal.id)
                                  .then((value) => presenter.fetchGoals());
                            },
                            icon: const Icon(Icons.add))
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
  GoalsPresenter initializePresenter() {
    return GoalsPresenter();
  }
}
