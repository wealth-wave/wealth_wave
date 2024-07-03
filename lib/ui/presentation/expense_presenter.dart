import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/services/expense_service.dart';
import 'package:wealth_wave/domain/services/expense_tag_service.dart';

class ExpensePresenter extends Presenter<ExpenseViewState> {
  final ExpenseTagService _expenseTagService;
  final ExpenseService _expenseService;

  ExpensePresenter(
      {final ExpenseService? expenseService,
      final ExpenseTagService? expenseTagService})
      : _expenseTagService = expenseTagService ?? ExpenseTagService(),
        _expenseService = expenseService ?? ExpenseService(),
        super(ExpenseViewState());

  void fetchTags() {
    _expenseTagService.get().then((tags) {
      tags.sort((a, b) => a.name.compareTo(b.name));
      updateViewState((viewState) {
        viewState.tags = tags.map((e) => e.name).toList();
        viewState.onTagsFetched = SingleEvent(null);
      });
    });
  }

  void fetchExpenses() {
    final tagsToFilter = getViewState().tagsToFilter;
    _expenseService.getAggregatedExpenses().then((expenses) {
      final monthlyExpenses = <DateTime, double>{};
      expenses
          .where((element) => element.tags
              .any((tag) => tagsToFilter.isEmpty || tagsToFilter.contains(tag)))
          .where((element) => element.createdMonthDate.isAfter(DateTime.now()
              .subtract(Duration(
                  days: getViewState().filterType ==
                          ExpenseFilterType.last12Months
                      ? 365
                      : 3650))))
          .forEach((element) {
        monthlyExpenses.update(
            element.createdMonthDate, (value) => value + element.amount,
            ifAbsent: () => element.amount);
      });
      updateViewState(
          (viewState) => viewState.monthlyExpenses = monthlyExpenses);
    });
  }

  void onTagsChanged({required final List<String> tags}) {
    updateViewState((viewState) => viewState.tagsToFilter = tags);
    fetchExpenses();
  }

  void onFilterTypeChanged({required final ExpenseFilterType filterType}) {
    updateViewState((viewState) => viewState.filterType = filterType);
    fetchExpenses();
  }
}

class ExpenseViewState {
  ExpenseFilterType filterType = ExpenseFilterType.last10Years;
  List<String> tagsToFilter = [];
  List<String> tags = [];
  Map<DateTime, double> monthlyExpenses = {};
  SingleEvent<void>? onTagsFetched;
}

enum ExpenseFilterType { last12Months, last10Years }

extension ExpenseFilterTypeDescription on ExpenseFilterType {
  String get description {
    switch (this) {
      case ExpenseFilterType.last12Months:
        return 'Last 12 Months';
      case ExpenseFilterType.last10Years:
        return 'Last 10 Years';
      default:
        return 'Unknown';
    }
  }
}
