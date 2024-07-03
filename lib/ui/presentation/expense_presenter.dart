import 'package:wealth_wave/core/presenter.dart';
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
      updateViewState((viewState) =>
          viewState.tagsToFilter = tags.map((e) => e.name).toList());
    });
  }

  void fetchExpenses() {
    final tagsToFilter = getViewState().tagsToFilter;
    _expenseService.getAggregatedExpenses().then((expenses) {
      final monthlyExpenses = <DateTime, double>{};
      expenses
          .where((element) => element.tags
              .any((tag) => tagsToFilter.isEmpty || tagsToFilter.contains(tag)))
          .forEach((element) {
        monthlyExpenses.update(
            element.createdMonthDate, (value) => value + element.amount,
            ifAbsent: () => element.amount);
      });
      updateViewState(
          (viewState) => viewState.monthlyExpenses = monthlyExpenses);
    });
  }
}

class ExpenseViewState {
  List<String> tagsToFilter = [];
  Map<DateTime, double> monthlyExpenses = {};
}
