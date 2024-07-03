import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
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
        _tagsController.setOptions(snapshot.tags
            .map((e) => ValueItem(label: e, value: e))
            .toList());
      });
    });

    Map<DateTime, double> monthlyExpenses = snapshot.monthlyExpenses;
    return Scaffold(
      body: Column(
        children: [
          _showFilterOptions(
              context: context,
              tags: snapshot.tags,
              selectedTags: snapshot.tagsToFilter,
              filterType: snapshot.filterType),
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
            showViewMonthlyExpensesDialog(
                context: context, monthDate: entry.key);
          },
        );
      },
    );
  }

  Widget _showFilterOptions(
      {required BuildContext context,
      required List<String> tags,
      required List<String> selectedTags,
      required ExpenseFilterType filterType}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: MultiSelectDropDown(
            controller: _tagsController,
            onOptionSelected: (options) {
              presenter.onTagsChanged(
                  tags: options.map((e) => e.value ?? '').toList());
            },
            options: tags.map((e) => ValueItem(label: e, value: e)).toList(),
            selectedOptions:
                selectedTags.map((e) => ValueItem(label: e, value: e)).toList(),
            chipConfig: const ChipConfig(wrapType: WrapType.wrap),
            dropdownHeight: 300,
            optionTextStyle: const TextStyle(fontSize: 16),
            selectedOptionIcon: const Icon(Icons.check_circle),
          ),
        ),
        Expanded(
          flex: 1,
          child: DropdownButton<ExpenseFilterType>(
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
        ),
      ],
    );
  }
}
