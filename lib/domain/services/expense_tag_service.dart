import 'package:wealth_wave/api/apis/expense_tag_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/expense_tag.dart';

class ExpenseTagService {
  final ExpenseTagApi _expenseTagApi;

  factory ExpenseTagService() {
    return _instance;
  }

  static final ExpenseTagService _instance = ExpenseTagService._();

  ExpenseTagService._({ExpenseTagApi? expenseTagApi})
      : _expenseTagApi = expenseTagApi ?? ExpenseTagApi();

  Future<void> create(
          {required final String name, required final String description}) =>
      _expenseTagApi
          .create(name: name, description: description)
          .then((_) => {});

  Future<List<ExpenseTag>> get() async {
    List<ExpenseTagDO> expenseTagDOs = await _expenseTagApi.get();
    return expenseTagDOs
        .map((basketDO) => ExpenseTag.from(expenseTagDO: basketDO))
        .toList();
  }

  Future<ExpenseTag> getById({required final int id}) async {
    ExpenseTagDO basketDO = await _expenseTagApi.getBy(id: id);
    return ExpenseTag.from(expenseTagDO: basketDO);
  }

  Future<void> update(
          {required final int id,
          required final String name,
          required final String? description}) =>
      _expenseTagApi
          .update(id: id, name: name, description: description)
          .then((_) => {});

  Future<void> deleteBy({required final int id}) =>
      _expenseTagApi.deleteBy(id: id);
}
