import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/expense_tag.dart';
import 'package:wealth_wave/domain/services/expense_tag_service.dart';

class CreateExpenseTagPresenter extends Presenter<CreateExpenseTagViewState> {
  final ExpenseTagService _expenseTagService;

  CreateExpenseTagPresenter({final ExpenseTagService? expenseTagService})
      : _expenseTagService = expenseTagService ?? ExpenseTagService(),
        super(CreateExpenseTagViewState());

  void fetchExpenseTag({required final int id}) {
    _expenseTagService.getById(id: id).then((tag) => _setExpenseTag(tag));
  }

  void createExpenseTag({final int? idToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String name = viewState.name;
    final String description = viewState.description;

    if (idToUpdate != null) {
      _expenseTagService
          .update(id: idToUpdate, name: name, description: description)
          .then((_) => updateViewState(
              (viewState) => viewState.onTagCreated = SingleEvent(null)));
    } else {
      _expenseTagService.create(name: name, description: description).then((_) =>
          updateViewState(
              (viewState) => viewState.onTagCreated = SingleEvent(null)));
    }
  }

  void onNameChanged(String text) {
    updateViewState((viewState) => viewState.name = text);
  }

  void onDescriptionChanged(String text) {
    updateViewState((viewState) => viewState.description = text);
  }

  void _setExpenseTag(ExpenseTag expenseTag) {
    updateViewState((viewState) {
      viewState.name = expenseTag.name;
      viewState.description = expenseTag.description ?? '';
      viewState.onTagFetched = SingleEvent(null);
    });
  }
}

class CreateExpenseTagViewState {
  String name = '';
  String description = '';
  SingleEvent<void>? onTagCreated;
  SingleEvent<void>? onTagFetched;

  bool isValid() {
    return name.isNotEmpty;
  }
}
