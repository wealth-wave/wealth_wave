import 'package:flutter/material.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/presentation/expense_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_expense_dialog.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePage();
}

class _ExpensePage
    extends PageState<ExpenseViewState, ExpensePage, ExpensePresenter> {
  @override
  void initState() {
    super.initState();
    presenter.fetchTags();
    presenter.fetchExpenses();
  }

  @override
  Widget buildWidget(
      final BuildContext context, final ExpenseViewState snapshot) {
    Map<DateTime, double> monthlyExpenses = snapshot.monthlyExpenses;
    return Scaffold(
      body: Center(
          child: Text('Monthly Expenses: $monthlyExpenses',
              style: Theme.of(context).textTheme.titleMedium)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateExpenseDialog(context: context).then((value) {
            presenter.fetchExpenses();
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  ExpensePresenter initializePresenter() {
    return ExpensePresenter();
  }
}
