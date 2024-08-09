import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pair/pair.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/presentation/expense_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_expense_dialog.dart';
import 'package:wealth_wave/ui/widgets/view_monthly_expenses_dialog.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      snapshot.onTagsFetched?.consume((_) {});
    });

    Map<DateTime, double> monthlyExpenses = snapshot.monthlyExpenses;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimen.minPadding),
            child: _showFilterOptions(
                context: context,
                tags: snapshot.tags,
                selectedTags: snapshot.tagsToFilter,
                filterType: snapshot.filterType),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(AppDimen.minPadding),
              padding: const EdgeInsets.all(AppDimen.minPadding),
              child: _showMonthlyExpenseGraph(
                  context: context, expenses: monthlyExpenses),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(AppDimen.minPadding),
              child: _showMonthlyExpenseList(
                  context: context, expenses: monthlyExpenses),
            ),
          ),
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

  Widget _showMonthlyExpenseGraph({
    required BuildContext context,
    required Map<DateTime, double> expenses,
  }) {
    List<Pair<String, double>> chartData = [];
    List<Pair<String, double>> cumulativeAverageData = [];
    double runningTotal = 0;
    int count = 0;

    List<MapEntry<DateTime, double>> expenseList = expenses.entries.toList();
    expenseList.sort((a, b) => a.key.compareTo(b.key));

    for (var entry in expenseList) {
      count++;
      runningTotal += entry.value;
      double cumulativeAverage = runningTotal / count;
      String month = DateFormat('MMM').format(DateTime.utc(entry.key.year, entry.key.month));
      chartData.add(Pair(month, entry.value));
      cumulativeAverageData.add(Pair(month, cumulativeAverage));
    }

    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: NumericAxis(
          numberFormat: NumberFormat.compactCurrency(
              symbol: '', locale: 'en_IN', decimalDigits: 0)),
      series: [
        ColumnSeries<Pair<String, double>, String>(
          dataSource: chartData,
          xValueMapper: (Pair<String, double> data, _) => data.key,
          yValueMapper: (Pair<String, double> data, _) => data.value,
          name: 'Expenses',
        ),
        LineSeries<Pair<String, double>, String>(
          dataSource: cumulativeAverageData,
          xValueMapper: (Pair<String, double> data, _) => data.key,
          yValueMapper: (Pair<String, double> data, _) => data.value,
          name: 'Cumulative Average',
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _showMonthlyExpenseList(
      {required BuildContext context,
      required Map<DateTime, double> expenses}) {
    List<Pair<DateTime, double>> sortedExpenses =
        expenses.entries.map((e) => Pair(e.key, e.value)).toList();
    sortedExpenses.sort((a, b) => b.key.compareTo(a.key));
    return ListView(
        children: sortedExpenses
            .map((e) => _expenseItem(
                context: context, month: e.key, amount: e.value))
            .toList());
  }

  Widget _expenseItem(
      {required final BuildContext context,
      required final DateTime month,
      required final double amount}) {
    return Card(
        margin: const EdgeInsets.all(AppDimen.minPadding),
        child: InkWell(
            onTap: () => {
                  showViewMonthlyExpensesDialog(
                          context: context, year: month.year, month: month.month)
                      .then((value) => presenter.fetchExpenses())
                },
            child: Padding(
              padding: const EdgeInsets.all(AppDimen.minPadding),
              child: OverflowBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getTitleWidget(
                      context: context, month: month, amount: amount),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(formatToCurrency(amount)),
                    ],
                  )
                ],
              ),
            )));
  }

  RichText _getTitleWidget(
      {required final BuildContext context,
      required final DateTime month,
      required final double amount}) {
    List<WidgetSpan> widgets = [];
    widgets.add(WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: PopupMenuButton<int>(
        onSelected: (value) {
          if (value == 1) {
            presenter.deleteMonthlyExpense(month: month);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text('Delete'),
          )
        ],
      ),
    ));
    return RichText(
        text: TextSpan(
            text: DateFormat('MMM yyyy').format(month),
            style: Theme.of(context).textTheme.titleMedium,
            children: widgets));
  }

  Widget _showFilterOptions({
    required BuildContext context,
    required List<String> tags,
    required List<String> selectedTags,
    required ExpenseFilterType filterType,
  }) {
    return Padding(
        padding: const EdgeInsets.all(AppDimen.defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MultiSelectDialogField<String>(
              items: tags.map((e) => MultiSelectItem(e, e)).toList(),
              initialValue: selectedTags,
              buttonText: const Text('Filter by Tags'),
              title: const Text('Select Tags'),
              listType: MultiSelectListType.CHIP,
              onConfirm: (options) {
                presenter.onTagsChanged(tags: options);
              },
            ),
            const Padding(padding: EdgeInsets.all(AppDimen.minPadding)),
            MultiSelectDialogField<ExpenseFilterType>(
              items: ExpenseFilterType.values
                  .map((e) => MultiSelectItem(e, e.description))
                  .toList(),
              buttonText: const Text('Filter by Duration'),
              title: const Text('Select Duration'),
              validator: (value) =>
                  (value?.length ?? 0) > 1 ? 'Select single duration' : null,
              listType: MultiSelectListType.CHIP,
              onConfirm: (options) {
                presenter.onFilterTypeChanged(filterType: options.first);
              },
            )
          ],
        ));
  }
}
