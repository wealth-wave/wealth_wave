import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:pair/pair.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/presentation/expense_presenter.dart';
import 'package:wealth_wave/ui/widgets/create_expense_dialog.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePage();
}

class _ExpensePage
    extends PageState<ExpenseViewState, ExpensePage, ExpensePresenter> {
  final _tagsController = MultiSelectController<String>();

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
      snapshot.onTagsFetched?.consume((_) {
        _tagsController.setOptions(
            snapshot.tags.map((e) => ValueItem(label: e, value: e)).toList());
      });
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

    for (var entry in expenses.entries) {
      count++;
      runningTotal += entry.value;
      double cumulativeAverage = runningTotal / count;
      String month = DateFormat('MMM').format(entry.key);
      chartData.add(Pair(month, entry.value));
      cumulativeAverageData.add(Pair(month, cumulativeAverage));
    }

    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: NumericAxis(numberFormat: NumberFormat.compactCurrency(symbol: '', locale: 'en_IN', decimalDigits: 0)),
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
                context: context, monthDate: e.key, amount: e.value))
            .toList());
  }

  Widget _expenseItem(
      {required final BuildContext context,
      required final DateTime monthDate,
      required final double amount}) {
    return Card(
        margin: const EdgeInsets.all(AppDimen.minPadding),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.minPadding),
          child: OverflowBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              _getTitleWidget(
                  context: context, monthDate: monthDate, amount: amount),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(formatToCurrency(amount)),
                ],
              )
            ],
          ),
        ));
  }

  RichText _getTitleWidget(
      {required final BuildContext context,
      required final DateTime monthDate,
      required final double amount}) {
    List<WidgetSpan> widgets = [];
    widgets.add(WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: PopupMenuButton<int>(
        onSelected: (value) {
          if (value == 1) {
            presenter.deleteMonthlyExpense(monthDate: monthDate);
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
            text: DateFormat('MMM yyyy').format(monthDate),
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
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Filter by Tag',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  MultiSelectDropDown(
                    controller: _tagsController,
                    onOptionSelected: (options) {
                      presenter.onTagsChanged(
                          tags: options.map((e) => e.value ?? '').toList());
                    },
                    options:
                        tags.map((e) => ValueItem(label: e, value: e)).toList(),
                    selectedOptions: selectedTags
                        .map((e) => ValueItem(label: e, value: e))
                        .toList(),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(AppDimen.minPadding)),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Filter by Duration',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  DropdownButton<ExpenseFilterType>(
                    isExpanded: true,
                    value: filterType,
                    items: ExpenseFilterType.values
                        .map((filterType) => DropdownMenuItem(
                              value: filterType,
                              child: Text(filterType.description),
                            ))
                        .toList(),
                    onChanged: (filterType) {
                      presenter.onFilterTypeChanged(filterType: filterType!);
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
