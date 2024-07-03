import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
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

  @override
  void initState() {
    super.initState();

    final viewState = presenter.getViewState();
    _descriptionController.text = viewState.description;
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
  }

  @override
  Widget buildWidget(BuildContext context, CreateExpenseViewState snapshot) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snapshot.onExpenseCreated?.consume((_) {
        Navigator.of(context).pop();
      });
      snapshot.onExpenseFetched?.consume((_) {
        _descriptionController.text = snapshot.description;
        _amountController.text = formatToCurrency(snapshot.amount);
        _createdOnController.text =
            snapshot.date != null ? formatDate(snapshot.date!) : '';
      });
      snapshot.onTagsFetched?.consume((_) {});
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
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Current Value', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _createdOnController,
              inputFormatters: [DateTextInputFormatter()],
              decoration: const InputDecoration(
                  labelText: 'Created Date', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppDimen.defaultPadding),
            MultiSelectDialogField<String>(
              buttonText: const Text('Choose Tags'),
              title: const Text('Select Tags'),
              items: snapshot.tags.map((e) => MultiSelectItem(e, e)).toList(),
              initialValue: snapshot.selected,
              listType: MultiSelectListType.CHIP,
              onConfirm: (options) {
                presenter.onTagsChanged(options);
              },
            ),
          ]),
        ));
  }

  @override
  CreateExpensePresenter initializePresenter() {
    return CreateExpensePresenter();
  }
}
