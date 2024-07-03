import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pair/pair.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/presentation/expense_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_expense_dialog.dart';
import 'package:wealth_wave/ui/widgets/view_monthly_expenses_dialog.dart';

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
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: _showMonthlyExpenseGraph(
                  context: context, expenses: monthlyExpenses)),
          Expanded(
              flex: 1,
              child: _showMonthlyExpenseList(
                  context: context, expenses: monthlyExpenses)),
        ],
      ),
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

  Widget _showMonthlyExpenseGraph(
      {required BuildContext context,
      required Map<DateTime, double> expenses}) {
    List<Pair<String, double>> chartData = expenses.entries
        .map((entry) => Pair(DateFormat('MMM').format(entry.key), entry.value))
        .toList();
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(),
      series: <ColumnSeries>[
        ColumnSeries<Pair<String, double>, String>(
          dataSource: chartData,
          xValueMapper: (Pair<String, double> data, _) => data.key,
          yValueMapper: (Pair<String, double> data, _) => data.value,
          name: 'Expenses',
        )
      ],
    );
  }

  Widget _showMonthlyExpenseList(
      {required BuildContext context,
      required Map<DateTime, double> expenses}) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        final entry = expenses.entries.elementAt(index);
        return ListTile(
          title: Text(DateFormat('MMM').format(entry.key)),
          subtitle: Text(entry.value.toString()),
          onTap: () {
            showViewMonthlyExpensesDialog(context: context, monthDate: entry.key);
          },
        );
      },
    );
  }
}
