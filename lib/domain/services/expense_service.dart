import 'package:wealth_wave/api/apis/aggregated_expense_api.dart';
import 'package:wealth_wave/api/apis/expense_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
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

  Future<void> createExpense({
    required final String? description,
    required final double amount,
    required final List<String> tags,
    required final DateTime createdOn,
  }) async {
    final tagsString = _processTags(tags: tags);
    await _updateAggregatedExpense(
        dateTime: createdOn, tags: tagsString, amount: amount);
    await _expenseApi.create(
      description: description,
      amount: amount,
      tags: tagsString,
      createdOn: createdOn,
    );
  }

  Future<void> updateExpense({
    required final int id,
    required final String? description,
    required final double amount,
    required final List<String> tags,
    required final DateTime createdOn,
  }) async {
    final existingExpenseDO = await _expenseApi.getBy(id: id);
    await _updateAggregatedExpense(
        dateTime: existingExpenseDO.createdOn,
        tags: existingExpenseDO.tags,
        amount: -existingExpenseDO.amount);

    final tagsString = _processTags(tags: tags);
    await _updateAggregatedExpense(
        dateTime: createdOn, tags: tagsString, amount: amount);
    await _expenseApi.update(
        id: id,
        amount: amount,
        description: description,
        createdOn: createdOn,
        tags: tagsString);
  }

  Future<Expense> getById({required final int id}) async {
    ExpenseDO expenseDO = await _expenseApi.getBy(id: id);
    return Expense.from(expenseDO: expenseDO);
  }

  Future<List<Expense>> getExpensesForMonthDate(
      {required final DateTime monthDate}) async {
    List<ExpenseDO> expenseDOs =
        await _expenseApi.getByMonth(monthDate: monthDate);
    return expenseDOs
        .map((expenseDO) => Expense.from(expenseDO: expenseDO))
        .toList();
  }

  Future<void> deleteBy({required final int id}) async {
    final existingExpenseDO = await _expenseApi.getBy(id: id);
    await _updateAggregatedExpense(
        dateTime: existingExpenseDO.createdOn,
        tags: existingExpenseDO.tags,
        amount: -existingExpenseDO.amount);
    await _expenseApi.deleteBy(id: id);
  }

  Future<void> deleteAggregatedExpense(
      {required final DateTime monthDate}) async {
    await _expenseApi.deleteByMonthDate(monthDate: monthDate);
    await _aggregatedExpenseApi.deleteByMonthDate(monthDate: monthDate);
  }

  Future<List<AggregatedExpense>> getAggregatedExpenses() async {
    List<AggregatedExpenseDO> aggregatedExpenseDOs =
        await _aggregatedExpenseApi.get();
    return aggregatedExpenseDOs
        .map((aggregatedExpenseDO) =>
            AggregatedExpense.from(expenseDO: aggregatedExpenseDO))
        .toList();
  }

  Future<void> _updateAggregatedExpense(
      {required final DateTime dateTime,
      required final String tags,
      required final double amount}) async {
    final monthDate = DateTime(dateTime.year, dateTime.month);
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
  }

  String _processTags({required final List<String> tags}) {
    tags.sort();
    return tags.join(',');
  }
}
