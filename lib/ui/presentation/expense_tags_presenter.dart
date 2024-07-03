import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/services/expense_tag_service.dart';
import 'package:wealth_wave/ui/models/expense_tag_vo.dart';

class ExpenseTagsPresenter extends Presenter<ExpenseTagsViewState> {
  final ExpenseTagService _expenseTagsService;

  ExpenseTagsPresenter({final ExpenseTagService? expenseTagServie})
      : _expenseTagsService = expenseTagServie ?? ExpenseTagService(),
        super(ExpenseTagsViewState());

  void fetchExpenseTags() {
    _expenseTagsService
        .get()
        .then((expenseTags) => expenseTags
            .map((expenseTag) => ExpenseTagVO.from(expenseTag: expenseTag))
            .toList())
        .then((expenseTags) => updateViewState(
            (viewState) => viewState.expenseTags = expenseTags));
  }

  void deleteTag({required final int id}) {
    _expenseTagsService.deleteBy(id: id).then((_) => fetchExpenseTags());
  }
}

class ExpenseTagsViewState {
  List<ExpenseTagVO> expenseTags = [];
}
