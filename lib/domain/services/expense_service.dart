import 'package:wealth_wave/api/apis/aggregated_expense_api.dart';
import 'package:wealth_wave/api/apis/expense_api.dart';
import 'package:wealth_wave/domain/models/aggregated_expense.dart';
import 'package:wealth_wave/domain/models/expense.dart';

class ExpenseService {
  final ExpenseApi _expenseApi;
  final AggregatedExpenseApi _aggregatedExpenseApi;

  factory ExpenseService() {
    return _instance;
  }

  static final ExpenseService _instance = ExpenseService._();

  ExpenseService._(
      {final ExpenseApi? expenseApi,
      final AggregatedExpenseApi? aggregatedExpenseApi})
      : _expenseApi = expenseApi ?? ExpenseApi(),
        _aggregatedExpenseApi = aggregatedExpenseApi ?? AggregatedExpenseApi();

  Future<Expense> createExpense({
    required final String? description,
    required final double amount,
    required final List<String> tags,
    required final DateTime createdOn,
  }) async {
    final int id = await _expenseApi.create(
      description: description,
      amount: amount,
      tags: tags,
      createdOn: createdOn,
    );
    final expenseDO = await _expenseApi.getBy(id: id);

    final DateTime monthDate = DateTime(createdOn.year, createdOn.month);
    final aggregatedExpense = await _aggregatedExpenseApi.getByMonthAndTag(
      monthDate: monthDate,
      tags: tags,
    );

    if (aggregatedExpense == null) {
      await _aggregatedExpenseApi.create(
        amount: amount,
        monthDate: monthDate,
        tags: tags,
      );
    } else {
      await _aggregatedExpenseApi.update(
        id: aggregatedExpense.id,
        amount: aggregatedExpense.amount + amount,
        createdOn: monthDate,
        tags: tags,
      );
    }

    return Expense.from(expenseDO: expenseDO);
  }

  Future<Expense> updateExpense({
    required final int id,
    required final String? description,
    required final double amount,
    required final List<String> tags,
    required final DateTime createdOn,
  }) async {
    final expenseDO = await _expenseApi.getBy(id: id);
    DateTime monthDate =
        DateTime(expenseDO.createdOn.year, expenseDO.createdOn.month);

    final aggregatedExpense = await _aggregatedExpenseApi.getByMonthAndTag(
        monthDate: monthDate, tags: tags);
    if (aggregatedExpense != null) {
      await _aggregatedExpenseApi.update(
        id: aggregatedExpense.id,
        amount: aggregatedExpense.amount -
            expenseDO.amount +
            amount, // Adjust the amount correctly
        createdOn: monthDate,
        tags: tags,
      );
    } else {
      await _aggregatedExpenseApi.create(
          amount: amount, monthDate: monthDate, tags: tags);
    }

    await _expenseApi.update(
      id: id,
      description: description,
      amount: amount,
      tags: tags,
      createdOn: createdOn,
    );

    return await _expenseApi
        .getBy(id: id)
        .then((value) => Expense.from(expenseDO: value));
  }

  Future<Expense> getById({required final int id}) => _expenseApi
      .getBy(id: id)
      .then((expenseDO) => Expense.from(expenseDO: expenseDO));

  Future<List<Expense>> getExpensesForMonthDate(
      {required final DateTime monthDate}) {
    return _expenseApi.getByMonth(monthDate: monthDate).then((expenseDOs) =>
        expenseDOs
            .map((expenseDO) => Expense.from(expenseDO: expenseDO))
            .toList());
  }

  Future<void> deleteBy({required final int id}) async {
    final expenseDO = await _expenseApi.getBy(id: id);
    DateTime monthDate =
        DateTime(expenseDO.createdOn.year, expenseDO.createdOn.month);
    final aggregatedExpense = await _aggregatedExpenseApi.getByMonthAndTag(
        monthDate: monthDate, tags: expenseDO.tags.split(','));

    if (aggregatedExpense != null) {
      await _aggregatedExpenseApi.update(
          id: aggregatedExpense.id,
          amount: aggregatedExpense.amount - expenseDO.amount,
          createdOn: monthDate,
          tags: expenseDO.tags.split(','));
    }

    await _expenseApi.deleteBy(id: id);
  }

  Future<void> deleteAggregatedExpense(
      {required final DateTime monthDate}) async {
    return _expenseApi
        .deleteByMonthDate(monthDate: monthDate)
        .then((value) =>
            _aggregatedExpenseApi.deleteByMonthDate(monthDate: monthDate))
        .then((value) => null);
  }

  Future<List<AggregatedExpense>> getAggregatedExpenses() =>
      _aggregatedExpenseApi.get().then((aggregatedExpenseDOs) =>
          aggregatedExpenseDOs
              .map((aggregatedExpenseDO) =>
                  AggregatedExpense.from(expenseDO: aggregatedExpenseDO))
              .toList());
}
