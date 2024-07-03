import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/expense.dart';
import 'package:wealth_wave/domain/services/expense_service.dart';
import 'package:wealth_wave/domain/services/expense_tag_service.dart';

class CreateExpensePresenter extends Presenter<CreateExpenseViewState> {
  final ExpenseService _expenseService;
  final ExpenseTagService _expenseTagService;

  CreateExpensePresenter(
      {final ExpenseService? expenseService,
      final ExpenseTagService? expenseTagService})
      : _expenseService = expenseService ?? ExpenseService(),
        _expenseTagService = expenseTagService ?? ExpenseTagService(),
        super(CreateExpenseViewState());

  void fetchTags() {
    _expenseTagService.get().then((tags) {
      tags.sort((a, b) => a.name.compareTo(b.name));
      updateViewState((viewState) {
        viewState.tags = tags.map((e) => e.name).toList();
        viewState.onTagsFetched = SingleEvent(null);
      });
    });
  }

  void fetchExpense({required final int id}) {
    _expenseService.getById(id: id).then((tag) => _setExpense(tag));
  }

  void createExpenseTag({final int? idToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final double amount = viewState.amount;
    final String description = viewState.description;
    final DateTime createdOn = viewState.date!;
    final List<String> tags = viewState.selected;
    tags.sort((a, b) => a.compareTo(b));

    if (idToUpdate != null) {
      _expenseService
          .updateExpense(
              id: idToUpdate,
              description: description,
              amount: amount,
              tags: tags,
              createdOn: createdOn)
          .then((_) => updateViewState(
              (viewState) => viewState.onExpenseCreated = SingleEvent(null)));
    } else {
      _expenseService
          .createExpense(
              description: description,
              amount: amount,
              tags: tags,
              createdOn: createdOn)
          .then((_) => updateViewState(
              (viewState) => viewState.onExpenseCreated = SingleEvent(null)));
    }
  }

  void onAmountChanged(double value) {
    updateViewState(
        (viewState) => viewState.amount = value);
  }

  void onDescriptionChanged(String text) {
    updateViewState((viewState) => viewState.description = text);
  }

  void onTagsChanged(List<String> tags) {
    updateViewState((viewState) => viewState.selected = tags);
  }

  void onCreatedOnChanged(DateTime? date) {
    updateViewState((viewState) => viewState.date = date);
  }

  void _setExpense(Expense expense) {
    updateViewState((viewState) {
      viewState.amount = expense.amount;
      viewState.description = expense.description ?? '';
      viewState.date = expense.createdOn;
      viewState.selected = expense.tags;
      viewState.onExpenseFetched = SingleEvent(null);
    });
  }
}

class CreateExpenseViewState {
  String description = '';
  double amount = 0;
  DateTime? date = DateTime.now();
  List<String> selected = [];
  List<String> tags = [];
  SingleEvent<void>? onTagsFetched;
  SingleEvent<void>? onExpenseCreated;
  SingleEvent<void>? onExpenseFetched;

  bool isValid() {
    return amount > 0;
  }
}
