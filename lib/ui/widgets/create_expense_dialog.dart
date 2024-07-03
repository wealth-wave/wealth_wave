import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:wealth_wave/core/page_state.dart';
import 'package:wealth_wave/ui/app_dimen.dart';
import 'package:wealth_wave/ui/custom/date_text_input_formatter.dart';
import 'package:wealth_wave/ui/presentation/create_expense_presenter.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

Future<void> showCreateExpenseDialog(
    {required final BuildContext context, final int? expenseIdTOUpdate}) {
  return showDialog(
      context: context,
      builder: (context) =>
          _CreateExpenseDialog(expenseIdTOUpdate: expenseIdTOUpdate));
}

class _CreateExpenseDialog extends StatefulWidget {
  final int? expenseIdTOUpdate;

  const _CreateExpenseDialog({this.expenseIdTOUpdate});

  @override
  State<_CreateExpenseDialog> createState() => _CreateExpensePage();
}

class _CreateExpensePage extends PageState<CreateExpenseViewState,
    _CreateExpenseDialog, CreateExpensePresenter> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _createdOnController = TextEditingController();
  final _tagsController = MultiSelectController<String>();

  @override
  void initState() {
    super.initState();

    final viewState = presenter.getViewState();
    _descriptionController.text = viewState.description;
    _tagsController.setSelectedOptions(
        viewState.selected.map((e) => ValueItem(label: e, value: e)).toList());
    _amountController.text = formatToCurrency(viewState.amount);
    _createdOnController.text =
        viewState.date != null ? formatDate(viewState.date!) : '';

    int? tagIdToUpdate = widget.expenseIdTOUpdate;
    presenter.fetchTags();
    if (tagIdToUpdate != null) {
      presenter.fetchExpense(id: tagIdToUpdate);
    }

    _amountController.addListener(() {
      presenter.onAmountChanged(parseCurrency(_amountController.text) ?? 0);
    });

    _descriptionController.addListener(() {
      presenter.onDescriptionChanged(_descriptionController.text);
    });

    _createdOnController.addListener(() {
      presenter.onCreatedOnChanged(parseDate(_createdOnController.text));
    });

    _tagsController.addListener(() {
      presenter.onTagsChanged(
          _tagsController.selectedOptions.map((e) => e.value ?? '').toList());
    });
  }

  @override
  Widget buildWidget(BuildContext context, CreateExpenseViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onExpenseCreated?.consume((_) {
        Navigator.of(context).pop();
      });
      snapshot.onExpenseFetched?.consume((_) {
        _descriptionController.text = snapshot.description;
        _tagsController.setSelectedOptions(snapshot.selected
            .map((e) => ValueItem(label: e, value: e))
            .toList());
        _amountController.text = formatToCurrency(snapshot.amount);
        _createdOnController.text =
            snapshot.date != null ? formatDate(snapshot.date!) : '';
      });
      snapshot.onTagsFetched?.consume((_) {
        _tagsController.setOptions(snapshot.tags
            .map((e) => ValueItem(label: e, value: e))
            .toList());
      });
    });

    return AlertDialog(
        title: Text('Create Expense',
            style: Theme.of(context).textTheme.titleMedium),
        actions: [
          ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              }),
          ElevatedButton(
            onPressed: snapshot.isValid()
                ? () {
                    presenter.createExpenseTag(
                        idToUpdate: widget.expenseIdTOUpdate);
                  }
                : null,
            child: widget.expenseIdTOUpdate != null
                ? const Text('Update')
                : const Text('Create'),
          ),
        ],
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(height: AppDimen.minPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder()),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Current Value', border: OutlineInputBorder()),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _createdOnController,
              inputFormatters: [DateTextInputFormatter()],
              decoration: const InputDecoration(
                  labelText: 'Created Date', border: OutlineInputBorder()),
            ),
            MultiSelectDropDown(
              controller: _tagsController,
              onOptionSelected: (options) {
                presenter
                    .onTagsChanged(options.map((e) => e.value ?? '').toList());
              },
              options: snapshot.tags
                  .map((e) => ValueItem(label: e, value: e))
                  .toList(),
              selectionType: SelectionType.multi,
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              dropdownHeight: 300,
              optionTextStyle: const TextStyle(fontSize: 16),
              selectedOptionIcon: const Icon(Icons.check_circle),
            ),
          ]),
        ));
  }

  @override
  CreateExpensePresenter initializePresenter() {
    return CreateExpensePresenter();
  }
}
