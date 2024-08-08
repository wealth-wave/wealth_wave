import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/services/expense_service.dart';
import 'package:wealth_wave/ui/models/expense_vo.dart';

class MonthlyExpensePresenter extends Presenter<MonthlyExpenseViewState> {
  final int _year;
  final int _month;
  final ExpenseService _expenseService;

  MonthlyExpensePresenter(
      {required final int year,
      required final int month,
      final ExpenseService? expenseService})
      : _year = year,
        _month = month,
        _expenseService = expenseService ?? ExpenseService(),
        super(MonthlyExpenseViewState());

  void getExpenses() {
    _expenseService
        .getExpensesForMonthDate(year: _year, month: _month)
        .then((expenses) => expenses
            .map((expense) => ExpenseVO.from(expense: expense))
            .toList())
        .then((expenses) => updateViewState((viewState) {
              viewState.expenses = expenses;
            }));
  }

  void deleteExpense({required final int id}) {
    _expenseService.deleteBy(id: id).then((_) => getExpenses());
  }
}

class MonthlyExpenseViewState {
  List<ExpenseVO> expenses = [];
}
